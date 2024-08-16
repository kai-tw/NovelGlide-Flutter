import 'package:hive/hive.dart';

import '../data/bookmark_data.dart';

class BookmarkProcessor {
  static const String bookmarkFileName = "bookmark.isar";
  static const String bookmarkLockFileName = "bookmark.isar.lock";

  static Future<List<BookmarkData>> getList() async {
    final Box<String> box = Hive.box(name: 'bookmark');
    List<BookmarkData> retList = [];

    for (int i = 0; i < box.length; i++) {
      retList.add(BookmarkData.fromJson(box.getAt(i)));
    }

    box.close();

    return retList;
  }

  static void save(BookmarkData data) {
    final Box<String> box = Hive.box(name: 'bookmark');
    box.put(data.bookName, data.toJson());
    box.close();
  }

  static BookmarkData? get(String bookName) {
    final Box<String> box = Hive.box(name: 'bookmark');
    final String? jsonValue = box.get(bookName);
    if (jsonValue != null) {
      return BookmarkData.fromJson(jsonValue);
    }
    return null;
  }

  static void delete(String bookName) {
    final Box<String> box = Hive.box(name: 'bookmark');
    box.delete(bookName);
    box.close();
  }

  /// Import the bookmark
  static void import(String bookName, String directoryPath, {bool isOverwrite = false}) {
    final Box<String> sourceBox = Hive.box(name: 'bookmark', directory: directoryPath);
    final Box<String> destBox = Hive.box(name: 'bookmark');

    for (String key in sourceBox.keys) {
      if (isOverwrite || !destBox.containsKey(key)) {
        destBox.put(key, sourceBox.get(key)!);
      }
    }
  }

  /// If the bookmark is at the chapter that is created or deleted, delete it.
  static void chapterCheck(String bookName, int chapterNumber) {
    final Box<String> box = Hive.box(name: 'bookmark');
    final String? jsonValue = box.get(bookName);

    if (jsonValue != null) {
      final BookmarkData data = BookmarkData.fromJson(jsonValue);
      if (data.chapterNumber == chapterNumber) {
        box.delete(bookName);
      }
    }

    box.close();
  }
}