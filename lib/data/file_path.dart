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
  late final String? downloadFolder;
  late final String? iosLibraryFolder;
  late final String? androidExternalStorage;

  late final String libraryRoot;
  late final String hiveRoot;
  late final String backupRoot;

  factory FilePath() => _instance;

  FilePath._init();

  Future<void> init() async {
    supportFolder = (await getApplicationSupportDirectory()).path;
    documentFolder = (await getApplicationDocumentsDirectory()).path;
    cacheFolder = (await getApplicationCacheDirectory()).path;
    tempFolder = (await getTemporaryDirectory()).path;
    downloadFolder = (await getDownloadsDirectory())?.path;
    iosLibraryFolder = Platform.isIOS ? (await getLibraryDirectory()).path : null;
    androidExternalStorage = Platform.isAndroid ? (await getExternalStorageDirectory())?.path : null;

    final String baseFolder = iosLibraryFolder ?? documentFolder;
    libraryRoot = join(baseFolder, 'Library');
    hiveRoot = join(baseFolder, "Hive");
    backupRoot = join(androidExternalStorage ?? documentFolder, 'Backups');

    _createIfNotExist(libraryRoot);
    _createIfNotExist(hiveRoot);
  }

  void _createIfNotExist(String path) {
    final Directory dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
  }
}
