import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:path/path.dart';

import 'file_path.dart';

class BackupUtils {
  static String libraryArchiveName = 'Library.zip';

  static Future<File> archiveLibrary(String tempFolderPath) async {
    final libraryFolder = Directory(FilePath.libraryRoot);

    // Create a zip file
    final zipFile = File(join(tempFolderPath, libraryArchiveName));
    zipFile.createSync();

    await ZipFile.createFromDirectory(
      sourceDir: libraryFolder,
      zipFile: zipFile,
    );

    return zipFile;
  }

  static Future<void> restoreBackup(Directory tempFolder, File zipFile) async {
    final libraryFolder = Directory(FilePath.libraryRoot);

    // Clear the Library folder.
    libraryFolder.deleteSync(recursive: true);
    libraryFolder.createSync(recursive: true);

    await ZipFile.extractToDirectory(
      zipFile: zipFile,
      destinationDir: libraryFolder,
    );
  }

  BackupUtils._();
}
