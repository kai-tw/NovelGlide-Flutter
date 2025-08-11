import 'dart:io';

import 'package:path/path.dart';

import '../../../../core/interfaces/google_api_interfaces/google_api_interfaces.dart';
import '../../../../core/log_system/log_system.dart';
import '../../../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../domain/repositories/bookmark_backup_repository.dart';

class BookmarkBackupRepositoryImpl implements BookmarkBackupRepository {
  BookmarkBackupRepositoryImpl(this._jsonPathProvider);

  final JsonPathProvider _jsonPathProvider;

  Future<String?> get googleDriveFileId async =>
      GoogleApiInterfaces.drive.getFileId(await fileName);

  @override
  Future<bool> deleteFromCloud() async {
    if ((await googleDriveFileId) == null) {
      LogSystem.error('Google Drive file id of the bookmark backup is null.');
      return false;
    }

    try {
      await GoogleApiInterfaces.drive.deleteFile((await googleDriveFileId)!);
    } catch (e, s) {
      LogSystem.error(
        'Delete bookmark backup from Google Drive failed.',
        error: e,
        stackTrace: s,
      );
      return false;
    }

    return !(await isBackupExists());
  }

  @override
  Future<String?> downloadFromCloud(
    String tempDirectoryPath,
    void Function(int downloaded, int total)? onDownload,
  ) async {
    if ((await googleDriveFileId) == null) {
      LogSystem.error('Google Drive file id of the bookmark backup is null.');
      return null;
    }

    final String jsonFile = join(tempDirectoryPath, await fileName);

    try {
      await GoogleApiInterfaces.drive.downloadFile(
        (await googleDriveFileId)!,
        File(jsonFile),
        onDownload: onDownload,
      );
    } catch (e, s) {
      LogSystem.error(
        'Download bookmark backup from Google Drive failed.',
        error: e,
        stackTrace: s,
      );
      return null;
    }

    return jsonFile;
  }

  @override
  Future<bool> isBackupExists() async =>
      GoogleApiInterfaces.drive.fileExists(await fileName);

  @override
  Future<String> get fileName async =>
      basename(await _jsonPathProvider.bookmarkJsonPath);

  @override
  Future<bool> uploadToCloud(
    void Function(int uploaded, int total)? onUpload,
  ) async {
    try {
      await GoogleApiInterfaces.drive.uploadFile(
        File(await _jsonPathProvider.bookmarkJsonPath),
        onUpload: onUpload,
      );
    } catch (e, s) {
      LogSystem.error(
        'Failed to upload bookmark backup to Google Drive.',
        error: e,
        stackTrace: s,
      );
      return false;
    }

    return isBackupExists();
  }
}
