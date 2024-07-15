import 'dart:io';

import 'package:path/path.dart';

import 'book_processor.dart';
import '../data/bookmark_data.dart';
import 'chapter_processor.dart';

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
        final BookmarkData bookmarkObject = BookmarkData.fromBookName(bookName);
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
    BookmarkData originalData = BookmarkData.fromBookName(bookName);
    if (isOverwrite || !originalData.isValid) {
      BookmarkData importData = BookmarkData.fromDirectory(directoryPath);
      importData = importData.copyWith(bookName: bookName);
      importData.save();
    }
  }

  /// If the bookmark is at the chapter that is creating, delete it.
  static void chapterCreateCheck(String bookName, int chapterNumber) {
    BookmarkData bookmarkData = BookmarkData.fromBookName(bookName);
    if (bookmarkData.chapterNumber == chapterNumber) {
      bookmarkData.clear();
    }
  }

  /// If the bookmark is at the chapter that is deleting, delete it.
  static void chapterDeleteCheck(String bookName, int chapterNumber) {
    if (!ChapterProcessor.isExist(bookName, chapterNumber)) {
      BookmarkData bookmarkData = BookmarkData.fromBookName(bookName);
      if (bookmarkData.chapterNumber == chapterNumber) {
        bookmarkData.clear();
      }
    }
  }
}