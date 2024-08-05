import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart';

import '../../../data/file_path.dart';
import '../../../processor/google_drive_api.dart';
import '../../../toolbox/random_utility.dart';

class BackupManagerGoogleDriveSelectCubit extends Cubit<BackupManagerGoogleDriveSelectState> {
  BackupManagerGoogleDriveSelectCubit() : super(const BackupManagerGoogleDriveSelectState());

  Future<void> init() async {
    try {
      await GoogleDriveApi.instance.signIn();
    } catch (e) {
      switch (e.runtimeType) {
        case GoogleDriveSignInException _:
          emit(const BackupManagerGoogleDriveSelectState(
            errorCode: BackupManagerGoogleDriveErrorCode.signInError,
          ));
          break;

        case GoogleDrivePermissionDeniedException _:
          emit(const BackupManagerGoogleDriveSelectState(
            errorCode: BackupManagerGoogleDriveErrorCode.permissionDenied,
          ));
          break;

        default:
          emit(const BackupManagerGoogleDriveSelectState(
            errorCode: BackupManagerGoogleDriveErrorCode.unknownError,
          ));
      }
    }
    await refresh();
  }

  Future<void> refresh() async {
    emit(const BackupManagerGoogleDriveSelectState(
      errorCode: BackupManagerGoogleDriveErrorCode.unInitialized,
    ));
    drive.FileList? fileList = await GoogleDriveApi.instance.list(
      spaces: 'appDataFolder',
      orderBy: 'createdTime desc',
      $fields: 'files(name,createdTime,id,mimeType)',
    );
    List<drive.File> files = fileList.files ?? [];

    emit(BackupManagerGoogleDriveSelectState(
      errorCode:
          files.isEmpty ? BackupManagerGoogleDriveErrorCode.emptyFolder : BackupManagerGoogleDriveErrorCode.normal,
      files: files,
    ));
  }

  Future<void> restoreBackup(String fileId) async {
    emit(state.copyWith(restoreState: BackupManagerGoogleDriveRestoreState.restoring));
    final Directory tempFolder = RandomUtility.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    final File zipFile = File(join(tempFolder.path, 'Library.zip'));
    zipFile.createSync();

    await GoogleDriveApi.instance.downloadFile(fileId, zipFile);

    final Directory library = Directory(FilePath.instance.libraryRoot);
    library.deleteSync(recursive: true);
    library.createSync(recursive: true);
    await ZipFile.extractToDirectory(zipFile: zipFile, destinationDir: library);

    tempFolder.deleteSync(recursive: true);

    if (!isClosed) {
      emit(state.copyWith(restoreState: BackupManagerGoogleDriveRestoreState.success));
      await Future.delayed(const Duration(seconds: 2));

      if (!isClosed) {
        state.copyWith(restoreState: BackupManagerGoogleDriveRestoreState.idle);
      }
    }
  }

  Future<void> deleteFile(String fileId) async {
    await GoogleDriveApi.instance.deleteFile(fileId);
    await refresh();
  }
}

class BackupManagerGoogleDriveSelectState extends Equatable {
  final BackupManagerGoogleDriveErrorCode errorCode;
  final BackupManagerGoogleDriveRestoreState restoreState;
  final List<drive.File>? files;

  @override
  List<Object?> get props => [
        errorCode,
        restoreState,
        files,
      ];

  const BackupManagerGoogleDriveSelectState({
    this.errorCode = BackupManagerGoogleDriveErrorCode.unInitialized,
    this.restoreState = BackupManagerGoogleDriveRestoreState.idle,
    this.files,
  });

  BackupManagerGoogleDriveSelectState copyWith({
    BackupManagerGoogleDriveErrorCode? errorCode,
    BackupManagerGoogleDriveRestoreState? restoreState,
    List<drive.File>? files,
  }) {
    return BackupManagerGoogleDriveSelectState(
      errorCode: errorCode ?? this.errorCode,
      restoreState: restoreState ?? this.restoreState,
      files: files ?? this.files,
    );
  }
}

enum BackupManagerGoogleDriveErrorCode {
  unInitialized,
  unknownError,
  signInError,
  permissionDenied,
  emptyFolder,
  normal,
}

enum BackupManagerGoogleDriveRestoreState { idle, restoring, success, failed }
