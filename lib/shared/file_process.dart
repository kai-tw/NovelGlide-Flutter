import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'book_object.dart';
import 'bookmark_object.dart';

enum FileProcessType { folder, file }

class FileProcess {
  /// Paths initialization.
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

  static Future<String> get libraryRoot async {
    final Directory folder = Directory(join(await supportFolder, 'Library'));
    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }
    return folder.path;
  }

  static Future<String> get hiveRoot async {
    final Directory folder = Directory(join(await supportFolder, 'Hive'));
    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }
    _createHiveFolders(folder.path);
    return folder.path;
  }

  static void _createHiveFolders(String rootPath) {
    for (var item in ['bookmarks']) {
      Directory itemDir = Directory(join(rootPath, item));
      if (!itemDir.existsSync()) {
        itemDir.create();
      }
    }
  }

  static Future<List<BookObject>> getBookList() async {
    final Directory folder = Directory(await FileProcess.libraryRoot);
    folder.createSync(recursive: true);
    final List<Directory> entries = folder.listSync().whereType<Directory>().toList();
    List<BookObject> list = entries.map((item) => BookObject.fromPath(item.path)).toList();
    list.sort((BookObject a, BookObject b) {
      return compareNatural(a.name, b.name);
    });
    return list;
  }

  static Future<List<BookmarkObject>> getBookmarkList() async {
    final Directory folder = Directory(join(await FileProcess.hiveRoot, 'bookmarks'));
    folder.createSync(recursive: true);
    return folder
        .listSync()
        .whereType<File>()
        .where((item) => extension(item.path) == '.isar')
        .map((item) => BookmarkObject.load(basenameWithoutExtension(item.path)))
        .where((item) => item.isValid)
        .toList();
  }
}
