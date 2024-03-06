import 'dart:io';

import 'package:collection/collection.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'book_object.dart';
import 'bookmark_object.dart';
import 'chapter_object.dart';
import 'verify_utility.dart';

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

  /// Books related.

  static Future<List<BookObject>> getBookList() async {
    final Directory folder = Directory(await libraryRoot);
    folder.createSync(recursive: true);
    final List<Directory> entries = folder.listSync().whereType<Directory>().toList();
    List<BookObject> list = entries.map((item) => BookObject.fromPath(item.path)).toList();
    list.sort((BookObject a, BookObject b) {
      return compareNatural(a.name, b.name);
    });
    return list;
  }

  static Future<BookObject?> getBookByName(String name) async {
    final Directory folder = Directory(join(await libraryRoot, name));
    if (folder.existsSync()) {
      return BookObject.fromPath(folder.path);
    }
    return null;
  }

  /// Chapters related.

  static Future<List<ChapterObject>> getChapterList(String bookName) async {
    final Directory folder = Directory(join(await libraryRoot, bookName));
    final List<ChapterObject> chapterList = [];
    if (folder.existsSync()) {
      List<String> entries = [];

      if (VerifyUtility.isFolderNameValid(bookName)) {
        final folder = Directory(join(await FileProcess.libraryRoot, bookName));
        if (folder.existsSync()) {
          RegExp regexp = RegExp(r'^\d+\.txt$');
          entries = folder
              .listSync()
              .whereType<File>()
              .where((item) => regexp.hasMatch(basename(item.path)) && lookupMimeType(item.path) == 'text/plain')
              .map<String>((item) => item.path)
              .toList();
          entries.sort(compareNatural);
        }
      }

      for (String item in entries) {
        final File file = File(item);
        final List<String> content = file.readAsLinesSync();
        if (content.isNotEmpty) {
          chapterList.add(ChapterObject(
            bookName: bookName,
            ordinalNumber: int.parse(basenameWithoutExtension(item)),
            title: content[0],
          ));
        } else {
          // If content is empty, delete it.
          file.delete();
        }
      }
    }
    return chapterList;
  }

  static Future<List<String>> getChapterContent(String bookName, int chapterNumber) async {
    final File file = File(join(await libraryRoot, bookName, "$chapterNumber.txt"));
    if (!file.existsSync()) {
      return [];
    }
    return file.readAsLinesSync().where((line) => line.isNotEmpty).toList();
  }

  /// Bookmarks related.

  static Future<List<BookmarkObject>> getBookmarkList() async {
    final Directory folder = Directory(join(await hiveRoot, 'bookmarks'));
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
