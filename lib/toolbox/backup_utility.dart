import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:path/path.dart';

import '../data/file_path.dart';

class BackupUtility {
  static Future<File> createBackup(String tempFolderPath) async {
    final File zipFile = File(join(tempFolderPath, 'Library_${DateTime.now().toIso8601String()}.zip'));
    zipFile.createSync();
    await ZipFile.createFromDirectory(sourceDir: Directory(FilePath.instance.libraryRoot), zipFile: zipFile);
    return zipFile;
  }
}
