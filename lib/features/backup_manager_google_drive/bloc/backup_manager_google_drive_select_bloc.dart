import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart';

import '../../../processor/google_drive_api.dart';

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
    FileList? fileList = await GoogleDriveApi.instance.driveApi!.files.list(
      spaces: 'appDataFolder',
      orderBy: 'createdTime desc',
      $fields: 'files(name,createdTime,id)',
    );
    List<File> files = fileList.files ?? [];

    emit(BackupManagerGoogleDriveSelectState(
      errorCode:
          files.isEmpty ? BackupManagerGoogleDriveErrorCode.emptyFolder : BackupManagerGoogleDriveErrorCode.normal,
      files: files,
    ));
  }

  Future<void> deleteFile(String fileId) async {
    await GoogleDriveApi.instance.driveApi!.files.delete(fileId);
    await refresh();
  }
}

class BackupManagerGoogleDriveSelectState extends Equatable {
  final BackupManagerGoogleDriveErrorCode errorCode;
  final List<File>? files;

  @override
  List<Object?> get props => [
        errorCode,
        files,
      ];

  const BackupManagerGoogleDriveSelectState({
    this.errorCode = BackupManagerGoogleDriveErrorCode.unInitialized,
    this.files,
  });
}

enum BackupManagerGoogleDriveErrorCode {
  unInitialized,
  unknownError,
  signInError,
  permissionDenied,
  emptyFolder,
  normal,
}
