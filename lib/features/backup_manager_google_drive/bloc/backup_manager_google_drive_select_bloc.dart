import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart';

import '../../../processor/google_drive_api.dart';
import '../../../toolbox/backup_utility.dart';
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

  Future<bool> restoreBackup(String fileId) async {
    final Directory tempFolder = await RandomUtility.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    final File zipFile = File(join(tempFolder.path, 'Library.zip'));
    zipFile.createSync();

    await GoogleDriveApi.instance.downloadFile(fileId, zipFile);

    await BackupUtility.restoreBackup(tempFolder, zipFile);

    tempFolder.deleteSync(recursive: true);
    return true;
  }

  Future<bool> deleteFile(String fileId) async {
    await GoogleDriveApi.instance.deleteFile(fileId);
    return true;
  }

  Future<bool> copyToDrive(String fileId) async {
    await GoogleDriveApi.instance.copyFile(fileId, ['root']);
    return true;
  }
}

class BackupManagerGoogleDriveSelectState extends Equatable {
  final BackupManagerGoogleDriveErrorCode errorCode;
  final List<drive.File>? files;

  @override
  List<Object?> get props => [
        errorCode,
        files,
      ];

  const BackupManagerGoogleDriveSelectState({
    this.errorCode = BackupManagerGoogleDriveErrorCode.unInitialized,
    this.files,
  });

  BackupManagerGoogleDriveSelectState copyWith({
    BackupManagerGoogleDriveErrorCode? errorCode,
    List<drive.File>? files,
  }) {
    return BackupManagerGoogleDriveSelectState(
      errorCode: errorCode ?? this.errorCode,
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
