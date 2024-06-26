import 'dart:io';

import 'package:path/path.dart';

import 'book_processor.dart';
import '../data/bookmark_data.dart';

class BookmarkProcessor {
  static const String bookmarkFileName = "bookmark.isar";
  static const String bookmarkLockFileName = "bookmark.isar.lock";

  static List<BookmarkData> getList() {
    List<BookmarkData> retList = [];
    List<String> bookList = BookProcessor.getNameList();

    for (String path in bookList) {
      final File file = File(join(path, bookmarkFileName));
      if (file.existsSync()) {
        final String bookName = basename(path);
        final BookmarkData bookmarkObject = BookmarkData.loadFromBookName(bookName);
        if (bookmarkObject.isValid) {
          retList.add(bookmarkObject);
        } else {
          bookmarkObject.clear();
        }
      }
    }

    return retList;
  }

  /// Import the bookmark
  static void import(String bookName, String directoryPath, {bool isOverwrite = false}) {
    BookmarkData originalData = BookmarkData.loadFromBookName(bookName);
    if (isOverwrite || !originalData.isValid) {
      BookmarkData importData = BookmarkData.loadFromDirectory(directoryPath);
      importData = importData.copyWith(bookName: bookName);
      importData.save();
    }
  }
}