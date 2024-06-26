import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FilePath {
  static final FilePath instance = _instance;
  static final FilePath _instance = FilePath._init();

  late final String supportFolder;
  late final String documentFolder;
  late final String cacheFolder;
  late final String tempFolder;

  late final String libraryRoot;
  late final String hiveRoot;

  factory FilePath() => _instance;

  FilePath._init();

  Future<void> init() async {
    supportFolder = (await getApplicationSupportDirectory()).path;
    documentFolder = (await getApplicationDocumentsDirectory()).path;
    cacheFolder = (await getApplicationCacheDirectory()).path;
    tempFolder = (await getTemporaryDirectory()).path;

    libraryRoot = join(documentFolder, 'Library');
    hiveRoot = join(documentFolder, "Hive");

    _createIfNotExist(libraryRoot);
    _createIfNotExist(hiveRoot);
  }

  void _createIfNotExist(String path) {
    final Directory dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
  }

  @override
  String toString() {
    return "Sup:\t$supportFolder\nDoc:\t$documentFolder\nCache:\t$cacheFolder\nTemp:\t$tempFolder";
  }
}