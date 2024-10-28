import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;

import '../../../utils/google_drive_api.dart';

class DeveloperPageGoogleDriveSelectCubit
    extends Cubit<DeveloperPageGoogleDriveSelectState> {
  DeveloperPageGoogleDriveSelectCubit()
      : super(const DeveloperPageGoogleDriveSelectState());

  Future<void> init() async {
    try {
      await GoogleDriveApi.instance.signIn();
    } catch (e) {
      switch (e.runtimeType) {
        case GoogleDriveSignInException _:
          emit(const DeveloperPageGoogleDriveSelectState(
            errorCode: BackupManagerGoogleDriveErrorCode.signInError,
          ));
          break;

        case GoogleDrivePermissionDeniedException _:
          emit(const DeveloperPageGoogleDriveSelectState(
            errorCode: BackupManagerGoogleDriveErrorCode.permissionDenied,
          ));
          break;

        default:
          emit(const DeveloperPageGoogleDriveSelectState(
            errorCode: BackupManagerGoogleDriveErrorCode.unknownError,
          ));
      }
    }
    await refresh();
  }

  Future<void> refresh() async {
    emit(const DeveloperPageGoogleDriveSelectState(
      errorCode: BackupManagerGoogleDriveErrorCode.unInitialized,
    ));
    drive.FileList? fileList = await GoogleDriveApi.instance.list(
      spaces: 'appDataFolder',
      orderBy: 'modifiedTime desc',
      $fields: 'files(name,createdTime,id,mimeType,modifiedTime)',
    );
    List<drive.File> files = fileList.files ?? [];

    emit(DeveloperPageGoogleDriveSelectState(
      errorCode: files.isEmpty
          ? BackupManagerGoogleDriveErrorCode.emptyFolder
          : BackupManagerGoogleDriveErrorCode.normal,
      files: files,
    ));
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

class DeveloperPageGoogleDriveSelectState extends Equatable {
  final BackupManagerGoogleDriveErrorCode errorCode;
  final List<drive.File>? files;

  @override
  List<Object?> get props => [
        errorCode,
        files,
      ];

  const DeveloperPageGoogleDriveSelectState({
    this.errorCode = BackupManagerGoogleDriveErrorCode.unInitialized,
    this.files,
  });

  DeveloperPageGoogleDriveSelectState copyWith({
    BackupManagerGoogleDriveErrorCode? errorCode,
    List<drive.File>? files,
  }) {
    return DeveloperPageGoogleDriveSelectState(
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
