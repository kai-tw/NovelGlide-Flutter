import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileProcess {
  // Paths initialization.
  static Future<String> get supportFolder async {
    final folder = await getApplicationSupportDirectory();
    return folder.path;
  }

  static Future<String> get documentFolder async {
    final folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }

  static Future<String> get cacheFolder async {
    final folder = await getApplicationCacheDirectory();
    return folder.path;
  }

  static Future<String> get tempFolder async {
    final folder = await getTemporaryDirectory();
    return folder.path;
  }

  // Constant enum
  static const typeFolder = 0;
  static const typeFile = 1;

  static void createIfNotExists(int type, String path) async {
    switch (type) {
      case typeFolder:
        final folder = Directory(path);
        if (!await folder.exists()) {
          folder.createSync(recursive: true);
        }
        break;
      case typeFile:
        final file = File(path);
        if (!await file.exists()) {
          file.createSync(recursive: true);
        }
        break;
    }
  }

  static Future<List<Directory>> getLibraryBookList() async {
    final String root = await supportFolder;
    final String libraryRoot = '$root/Library';
    createIfNotExists(typeFolder, libraryRoot);
    final folder = Directory(libraryRoot);
    final entries = folder.listSync().whereType<Directory>().toList();
    return entries;
  }
}
