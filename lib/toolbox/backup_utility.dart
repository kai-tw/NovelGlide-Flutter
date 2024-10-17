import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:path/path.dart';

import 'file_path.dart';

class BackupUtility {
  static Future<File> createBackup(String tempFolderPath) async {
    final String libraryRoot = await FilePath.libraryRoot;
    final Directory libraryFolder = Directory(libraryRoot);

    // Create a zip file
    final File zipFile = File(join(tempFolderPath, 'Library.zip'));
    zipFile.createSync();

    await ZipFile.createFromDirectory(
        sourceDir: libraryFolder, zipFile: zipFile);

    return zipFile;
  }

  static Future<void> restoreBackup(Directory tempFolder, File zipFile) async {
    final String libraryRoot = await FilePath.libraryRoot;
    final Directory libraryFolder = Directory(libraryRoot);

    // Clear the Library folder.
    libraryFolder.deleteSync(recursive: true);
    libraryFolder.createSync(recursive: true);

    await ZipFile.extractToDirectory(
      zipFile: zipFile,
      destinationDir: libraryFolder,
    );
  }

  BackupUtility._();
}
