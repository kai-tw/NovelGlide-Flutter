import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'file_process.dart';

class FilePath {
  late final String supportFolder;
  late final String documentFolder;
  late final String cacheFolder;
  late final String tempFolder;

  late final String libraryRoot;
  late final String hiveRoot;

  Future<void> init() async {
    supportFolder = (await getApplicationSupportDirectory()).path;
    documentFolder = (await getApplicationDocumentsDirectory()).path;
    cacheFolder = (await getApplicationCacheDirectory()).path;
    tempFolder = (await getTemporaryDirectory()).path;

    // Library.
    final Directory libraryFolder = Directory(join(supportFolder, 'Library'));
    if (!libraryFolder.existsSync()) {
      libraryFolder.createSync(recursive: true);
    }
    libraryRoot = libraryFolder.path;

    // Hive
    final Directory hiveFolder = Directory(join(supportFolder, 'Hive'));
    if (!hiveFolder.existsSync()) {
      hiveFolder.createSync(recursive: true);
    }
    FileProcess.createHiveFolders(hiveFolder.path);
    hiveRoot = hiveFolder.path;
  }
}

FilePath filePath = FilePath();