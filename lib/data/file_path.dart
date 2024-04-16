import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FilePath {
  static final FilePath instance = FilePath._init();

  late final String supportFolder;
  late final String documentFolder;
  late final String cacheFolder;
  late final String tempFolder;

  late final String libraryRoot;
  late final String hiveRoot;

  factory FilePath() {
    return instance;
  }

  FilePath._init();

  Future<void> init() async {
    supportFolder = (await getApplicationSupportDirectory()).path;
    documentFolder = (await getApplicationDocumentsDirectory()).path;
    cacheFolder = (await getApplicationCacheDirectory()).path;
    tempFolder = (await getTemporaryDirectory()).path;

    Directory folder;

    // Library.
    folder = Directory(join(documentFolder, 'Library'));
    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }
    libraryRoot = folder.path;

    // Hive
    hiveRoot = documentFolder;
  }

  @override
  String toString() {
    return "Sup:\t$supportFolder\nDoc:\t$documentFolder\nCache:\t$cacheFolder\nTemp:\t$tempFolder";
  }
}