part of '../developer_page.dart';

class _GoogleDriveCubit extends Cubit<_GoogleDriveState> {
  _GoogleDriveCubit() : super(const _GoogleDriveState());

  Future<void> init() async {
    try {
      await GoogleDriveApi.instance.signIn();
    } catch (e) {
      switch (e.runtimeType) {
        case GoogleDriveSignInException _:
          emit(const _GoogleDriveState(
            errorCode: _GoogleDriveErrorCode.signInError,
          ));
          break;

        case GoogleDrivePermissionDeniedException _:
          emit(const _GoogleDriveState(
            errorCode: _GoogleDriveErrorCode.permissionDenied,
          ));
          break;

        default:
          emit(const _GoogleDriveState(
            errorCode: _GoogleDriveErrorCode.unknownError,
          ));
      }
    }
    await refresh();
  }

  Future<void> refresh() async {
    emit(const _GoogleDriveState(
      errorCode: _GoogleDriveErrorCode.unInitialized,
    ));
    drive.FileList? fileList = await GoogleDriveApi.instance.list(
      spaces: 'appDataFolder',
      orderBy: 'modifiedTime desc',
      $fields: 'files(name,createdTime,id,mimeType,modifiedTime)',
    );
    List<drive.File> files = fileList.files ?? [];

    emit(_GoogleDriveState(
      errorCode: files.isEmpty
          ? _GoogleDriveErrorCode.emptyFolder
          : _GoogleDriveErrorCode.normal,
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

class _GoogleDriveState extends Equatable {
  final _GoogleDriveErrorCode errorCode;
  final List<drive.File>? files;

  @override
  List<Object?> get props => [
        errorCode,
        files,
      ];

  const _GoogleDriveState({
    this.errorCode = _GoogleDriveErrorCode.unInitialized,
    this.files,
  });

  _GoogleDriveState copyWith({
    _GoogleDriveErrorCode? errorCode,
    List<drive.File>? files,
  }) {
    return _GoogleDriveState(
      errorCode: errorCode ?? this.errorCode,
      files: files ?? this.files,
    );
  }
}

enum _GoogleDriveErrorCode {
  unInitialized,
  unknownError,
  signInError,
  permissionDenied,
  emptyFolder,
  normal,
}
