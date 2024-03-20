import 'dart:io';

import 'package:collection/collection.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import 'book_object.dart';
import 'bookmark_object.dart';
import 'chapter_object.dart';
import 'file_path.dart';
import 'verify_utility.dart';

class FileProcess {
  static void createHiveFolders(String rootPath) {
    for (var item in ['bookmarks']) {
      Directory itemDir = Directory(join(rootPath, item));
      if (!itemDir.existsSync()) {
        itemDir.create();
      }
    }
  }

  /// Books related.
  static List<BookObject> getBookList() {
    final Directory folder = Directory(filePath.libraryRoot);
    folder.createSync(recursive: true);
    final List<Directory> entries = folder.listSync().whereType<Directory>().toList();
    List<BookObject> list = entries.map((item) => BookObject.fromPath(item.path)).toList();
    list.sort((BookObject a, BookObject b) {
      return compareNatural(a.name, b.name);
    });
    return list;
  }

  static BookObject getBookByName(String name) {
    return BookObject.fromPath(getBookPathByName(name));
  }

  static String getBookPathByName(String name) {
    return join(filePath.libraryRoot, name);
  }

  static Directory getBookDirectoryByName(String name) {
    return Directory(getBookPathByName(name));
  }

  /// Chapters related.
  static List<ChapterObject> getChapterList(String bookName) {
    final Directory folder = Directory(join(filePath.libraryRoot, bookName));
    final List<ChapterObject> chapterList = [];
    if (folder.existsSync()) {
      List<String> entries = [];

      if (VerifyUtility.isFolderNameValid(bookName)) {
        final folder = Directory(join(filePath.libraryRoot, bookName));
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

  static List<String> getChapterContent(String bookName, int chapterNumber) {
    final File file = File(join(filePath.libraryRoot, bookName, "$chapterNumber.txt"));
    if (!file.existsSync()) {
      return [];
    }
    return file.readAsLinesSync().where((line) => line.isNotEmpty).toList();
  }

  /// Bookmarks related.
  static List<BookmarkObject> getBookmarkList() {
    final Directory folder = Directory(join(filePath.hiveRoot, 'bookmarks'));
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
