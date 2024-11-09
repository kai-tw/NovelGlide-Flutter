import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:path/path.dart';

import 'file_path.dart';

class BackupUtils {
  static String libraryArchiveName = 'Library.zip';

  static Future<File> archiveLibrary(
    String tempFolderPath, {
    void Function(double)? onZipping,
  }) async {
    final libraryFolder = Directory(FilePath.libraryRoot);

    // Create a zip file
    final zipFile = File(join(tempFolderPath, libraryArchiveName));

    await ZipFile.createFromDirectory(
      sourceDir: libraryFolder,
      zipFile: zipFile,
      onZipping: (fileName, isDirectory, progress) {
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
    final libraryFolder = Directory(FilePath.libraryRoot);

    // Clear the Library folder.
    libraryFolder.deleteSync(recursive: true);
    libraryFolder.createSync(recursive: true);

    await ZipFile.extractToDirectory(
      zipFile: zipFile,
      destinationDir: libraryFolder,
      onExtracting: (entry, progress) {
        // Only extract epub files.
        onExtracting?.call(progress);
        return extension(entry.name) == '.epub'
            ? ZipFileOperation.includeItem
            : ZipFileOperation.skipItem;
      },
    );
  }

  BackupUtils._();
}
