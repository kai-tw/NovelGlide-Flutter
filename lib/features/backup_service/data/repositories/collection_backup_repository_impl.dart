import 'dart:typed_data';

import 'package:path/path.dart';

import '../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../core/log_system/log_system.dart';
import '../../../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../../cloud/domain/entities/cloud_file.dart';
import '../../../cloud/domain/entities/cloud_providers.dart';
import '../../../cloud/domain/repositories/cloud_repository.dart';
import '../../domain/repositories/collection_backup_repository.dart';

class CollectionBackupRepositoryImpl implements CollectionBackupRepository {
  CollectionBackupRepositoryImpl(
    this._jsonPathProvider,
    this._fileSystemRepository,
    this._cloudRepository,
  );

  final JsonPathProvider _jsonPathProvider;
  final FileSystemRepository _fileSystemRepository;
  final CloudRepository _cloudRepository;

  final CloudProviders _cloudProvider = CloudProviders.google;

  Future<CloudFile?> get _file async =>
      await _cloudRepository.getFile(_cloudProvider, await fileName);

  @override
  Future<String> get fileName async =>
      basename(await _jsonPathProvider.collectionJsonPath);

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
        'Delete collection backup from cloud failed '
        'because the file does not exist.',
      );
      return false;
    }

    try {
      await _cloudRepository.deleteFile(_cloudProvider, file.identifier);
    } catch (e, s) {
      LogSystem.error(
        'Delete collection backup from cloud failed.',
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
        'Download collection backup from cloud failed '
        'because the file does not exist.',
      );
      return null;
    }

    // Create an empty file to store the downloaded json file.
    final String jsonFile = join(tempDirectoryPath, await fileName);
    await _fileSystemRepository.createFile(jsonFile);

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
      await _fileSystemRepository.writeFileAsBytes(jsonFile, buffer);
    } catch (e, s) {
      LogSystem.error(
        'An error occurred while downloading and '
        'processing the collection backup file from cloud',
        error: e,
        stackTrace: s,
      );
      return null;
    }

    return jsonFile;
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
        await _jsonPathProvider.collectionJsonPath,
        onUpload: onUpload,
      );
    } catch (e, s) {
      LogSystem.error(
        'Failed to upload collection backup to cloud.',
        error: e,
        stackTrace: s,
      );
      return false;
    }

    return isBackupExists();
  }
}
