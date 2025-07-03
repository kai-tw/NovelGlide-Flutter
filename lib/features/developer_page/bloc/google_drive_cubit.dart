part of '../developer_page.dart';

class _GoogleDriveCubit extends Cubit<_GoogleDriveState> {
  _GoogleDriveCubit() : super(const _GoogleDriveState());

  Future<void> init() async {
    await GoogleServices.driveService.signIn();
    await refresh();
  }

  Future<void> refresh() async {
    emit(const _GoogleDriveState(
      errorCode: _GoogleDriveErrorCode.unInitialized,
    ));
    final drive.FileList fileList =
        await GoogleServices.driveService.files.list(
      spaces: 'appDataFolder',
      orderBy: 'modifiedTime desc',
      $fields: 'files(name,createdTime,id,mimeType,modifiedTime)',
    );
    final List<drive.File> files = fileList.files ?? <drive.File>[];

    emit(_GoogleDriveState(
      errorCode: files.isEmpty
          ? _GoogleDriveErrorCode.emptyFolder
          : _GoogleDriveErrorCode.normal,
      files: files,
    ));
  }

  Future<bool> deleteFile(String fileId) async {
    await GoogleServices.driveService.deleteFile(fileId);
    return true;
  }

  Future<bool> copyToDrive(String fileId) async {
    await GoogleServices.driveService.copyFile(fileId, <String>['root']);
    return true;
  }
}

class _GoogleDriveState extends Equatable {
  const _GoogleDriveState({
    this.errorCode = _GoogleDriveErrorCode.unInitialized,
    this.files,
  });

  final _GoogleDriveErrorCode errorCode;
  final List<drive.File>? files;

  @override
  List<Object?> get props => <Object?>[
        errorCode,
        files,
      ];

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
