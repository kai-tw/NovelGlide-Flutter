import 'dart:typed_data';

import 'package:path/path.dart';

import '../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../core/log_system/log_system.dart';
import '../../../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../../cloud/domain/entities/cloud_file.dart';
import '../../../cloud/domain/entities/cloud_providers.dart';
import '../../../cloud/domain/repositories/cloud_repository.dart';
import '../../domain/repositories/bookmark_backup_repository.dart';

class BookmarkBackupRepositoryImpl implements BookmarkBackupRepository {
  BookmarkBackupRepositoryImpl(
    this._jsonPathProvider,
    this._fileSystemRepository,
    this._cloudRepository,
  );

  final JsonPathProvider _jsonPathProvider;
  final FileSystemRepository _fileSystemRepository;
  final CloudRepository _cloudRepository;

  final CloudProviders _cloudProvider = CloudProviders.google;

  Future<CloudFile?> get _file async =>
      _cloudRepository.getFile(_cloudProvider, await fileName);

  @override
  Future<String> get fileName async =>
      basename(await _jsonPathProvider.bookmarkJsonPath);

  @override
  Future<DateTime?> get lastBackupTime async {
    final CloudFile? file = await _file;
    return file?.modifiedTime;
  }

  @override
  Future<bool> deleteFromCloud() async {
    final CloudFile? file = await _file;

    if (file == null) {
      LogSystem.error(
        'Delete bookmark backup from cloud failed '
        'because the file does not exist.',
      );
      return false;
    }

    try {
      await _cloudRepository.deleteFile(_cloudProvider, file.identifier);
    } catch (e, s) {
      LogSystem.error(
        'Delete bookmark backup from cloud failed.',
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
    void Function(double progress)? onDownload,
  ) async {
    final CloudFile? file = await _file;

    if (file == null) {
      LogSystem.error(
        'Download bookmark backup from cloud failed '
        'because the file does not exist.',
      );
      return null;
    }

    // Create the temporary json file.
    final String jsonPath = join(tempDirectoryPath, await fileName);
    await _fileSystemRepository.createFile(jsonPath);

    try {
      // Create the stream of the file.
      final Stream<Uint8List> cloudFileStream = _cloudRepository.downloadFile(
        _cloudProvider,
        file.identifier,
        onDownload: onDownload,
      );

      // Create the buffer to store the downloaded data.
      final Uint8List buffer = Uint8List(file.length);

      // Read the data from the stream and write it to the buffer.
      int offset = 0;
      await for (Uint8List chunk in cloudFileStream) {
        buffer.setAll(offset, chunk);
        offset += chunk.length;
      }

      // Write the buffer to the file.
      _fileSystemRepository.writeFileAsBytes(jsonPath, buffer);
    } catch (e, s) {
      LogSystem.error(
        'An error occurred while downloading and '
        'processing the bookmark backup file from cloud',
        error: e,
        stackTrace: s,
      );
      return null;
    }

    return jsonPath;
  }

  @override
  Future<bool> isBackupExists() async => await _file != null;

  @override
  Future<bool> uploadToCloud(
    void Function(double progress)? onUpload,
  ) async {
    try {
      await _cloudRepository.uploadFile(
        _cloudProvider,
        await _jsonPathProvider.bookmarkJsonPath,
        onUpload: onUpload,
      );
    } catch (e, s) {
      LogSystem.error(
        'Failed to upload bookmark backup to cloud.',
        error: e,
        stackTrace: s,
      );
      return false;
    }

    return isBackupExists();
  }
}
