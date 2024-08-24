import 'dart:io';

import 'package:hive/hive.dart';

import '../data/bookmark_data.dart';

class BookmarkProcessor {
  static const String bookmarkFileName = "bookmark.isar";
  static const String bookmarkLockFileName = "bookmark.isar.lock";

  static Future<List<BookmarkData>> getList() async {
    final Box<String> box = Hive.box(name: 'bookmark');
    List<BookmarkData> retList = [];

    for (int i = 0; i < box.length; i++) {
      final BookmarkData data = BookmarkData.fromJson(box.getAt(i));
      if (File(data.bookPath).existsSync()) {
        retList.add(data);
      } else {
        box.deleteAt(i);
      }
    }

    box.close();

    return retList;
  }

  static BookmarkData? get(String bookPath) {
    final Box<String> box = Hive.box(name: 'bookmark');
    final String? jsonValue = box.get(bookPath);
    if (jsonValue != null) {
      return BookmarkData.fromJson(jsonValue);
    }
    return null;
  }
}