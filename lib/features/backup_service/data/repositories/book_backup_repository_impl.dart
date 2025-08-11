import 'dart:async';
import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:path/path.dart';

import '../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../core/interfaces/google_api_interfaces/google_api_interfaces.dart';
import '../../../../core/log_system/log_system.dart';
import '../../../../core/path_provider/domain/repositories/app_path_provider.dart';
import '../../../books/domain/repositories/book_repository.dart';
import '../../domain/repositories/book_backup_repository.dart';

class BookBackupRepositoryImpl implements BookBackupRepository {
  BookBackupRepositoryImpl(
    this._pathProvider,
    this._fileSystemRepository,
    this._bookRepository,
  );

  final AppPathProvider _pathProvider;
  final FileSystemRepository _fileSystemRepository;
  final BookRepository _bookRepository;

  Future<String?> get googleDriveFileId async =>
      GoogleApiInterfaces.drive.getFileId(await archiveName);

  @override
  Future<String> archive(
    String tempDirectoryPath,
    void Function(double progress)? onZipping,
  ) async {
    final String libraryFolder = await _pathProvider.libraryPath;

    // Create the zip file
    final File zipFile = await _fileSystemRepository
        .createFile(join(tempDirectoryPath, await archiveName));

    // Start archiving books
    await ZipFile.createFromDirectory(
      sourceDir: Directory(libraryFolder),
      zipFile: zipFile,
      onZipping: (String fileName, bool isDirectory, double progress) {
        // Call callback for sending the progress.
        onZipping?.call(progress / 100);

        // Only check the extension is acceptable.
        final String ext = extension(fileName);
        return _bookRepository.allowedExtensions.contains(ext.substring(1))
            ? ZipFileOperation.includeItem
            : ZipFileOperation.skipItem;
      },
    );

    return zipFile.path;
  }

  @override
  Future<String> get archiveName async => 'Library.zip';

  @override
  Future<DateTime?> get lastBackupTime async {
    final String? fileId = await googleDriveFileId;

    if (fileId == null) {
      return null;
    } else {
      return (await GoogleApiInterfaces.drive
              .getMetadataById(fileId, field: 'modifiedTime'))
          .modifiedTime;
    }
  }

  @override
  Future<bool> deleteFromCloud() async {
    if (await googleDriveFileId == null) {
      LogSystem.error('Delete library backup failed.'
          'Google Drive file id is null.');
      return false;
    }

    // Delete the file from Google Drive.
    final String? fileId = await googleDriveFileId;
    await GoogleApiInterfaces.drive.deleteFile(fileId!);

    // Success if it doesn't exist.
    return !(await isBackupExists());
  }

  @override
  Future<String?> downloadFromCloud(
    String tempDirectoryPath,
    void Function(int downloaded, int total)? onDownload,
  ) async {
    if (await googleDriveFileId == null) {
      LogSystem.error('Download library backup failed.'
          'Google Drive file id is null');
      return null;
    }

    // Create an empty file to store the downloaded zip file.
    final String zipFilePath = join(tempDirectoryPath, await archiveName);
    final File zipFile = await _fileSystemRepository.createFile(zipFilePath);

    try {
      final String? fileId = await googleDriveFileId;
      await GoogleApiInterfaces.drive
          .downloadFile(fileId!, zipFile, onDownload: onDownload);
    } catch (e) {
      // An error occurred.
      LogSystem.error('Google Drive download file failed', error: e);
      return null;
    }

    return zipFilePath;
  }

  @override
  Future<void> extract(
    String zipFilePath,
    String tempDirectoryPath,
    void Function(double progress)? onExtracting,
  ) async {
    // Extract files to temporary directory.
    await ZipFile.extractToDirectory(
      zipFile: File(zipFilePath),
      destinationDir: Directory(tempDirectoryPath),
      onExtracting: (ZipEntry entry, double progress) {
        // Only extract epub files.
        onExtracting?.call(progress / 100);

        // Determine if the file should be extracted or not.
        return !entry.isDirectory && extension(entry.name) == '.epub'
            ? ZipFileOperation.includeItem
            : ZipFileOperation.skipItem;
      },
    );

    final Set<String> importSet = <String>{};

    // Get all paths of every book.
    await for (FileSystemEntity entity
        in _fileSystemRepository.listDirectory(tempDirectoryPath)) {
      // Only import the valid files.
      if (entity is File && await _bookRepository.isFileValid(entity.path)) {
        importSet.add(entity.path);
      }
    }

    // Delete all books in the library
    await _bookRepository.reset();

    // Perform add book procedures
    await _bookRepository.addBooks(importSet);
  }

  @override
  Future<bool> isBackupExists() async {
    return GoogleApiInterfaces.drive.fileExists(await archiveName);
  }

  @override
  Future<bool> uploadToCloud(
    String zipFilePath,
    void Function(int uploaded, int total)? onUpload,
  ) async {
    try {
      await GoogleApiInterfaces.drive
          .uploadFile(File(zipFilePath), onUpload: onUpload);
    } catch (e) {
      // An error occurred.
      LogSystem.error('Upload library zip to Google Drive failed', error: e);
      return false;
    }

    return isBackupExists();
  }
}
