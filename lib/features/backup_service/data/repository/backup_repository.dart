import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:path/path.dart';

import '../../../../core/utils/file_path.dart';

class BackupRepository {
  BackupRepository._();

  static const String libraryArchiveName = 'Library.zip';

  static Future<File> archiveLibrary(
    String tempFolderPath, {
    void Function(double)? onZipping,
  }) async {
    final Directory libraryFolder = Directory(FilePath.libraryRoot);

    // Create a zip file
    final File zipFile = File(join(tempFolderPath, libraryArchiveName));

    await ZipFile.createFromDirectory(
      sourceDir: libraryFolder,
      zipFile: zipFile,
      onZipping: (String fileName, bool isDirectory, double progress) {
        // Only include epub files.
        onZipping?.call(progress);
        return extension(fileName) == '.epub'
            ? ZipFileOperation.includeItem
            : ZipFileOperation.skipItem;
      },
    );

    return zipFile;
  }

  static Future<void> restoreBackup(
    Directory tempFolder,
    File zipFile, {
    void Function(double)? onExtracting,
  }) async {
    final Directory libraryFolder = Directory(FilePath.libraryRoot);

    // Clear the Library folder.
    libraryFolder.deleteSync(recursive: true);
    libraryFolder.createSync(recursive: true);

    await ZipFile.extractToDirectory(
      zipFile: zipFile,
      destinationDir: libraryFolder,
      onExtracting: (ZipEntry entry, double progress) {
        // Only extract epub files.
        onExtracting?.call(progress);
        return extension(entry.name) == '.epub'
            ? ZipFileOperation.includeItem
            : ZipFileOperation.skipItem;
      },
    );
  }
}
