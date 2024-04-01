import 'dart:io';

import 'package:path/path.dart';

import 'book_utility.dart';
import '../data/bookmark_data.dart';

class BookmarkUtility {
  static List<BookmarkData> getList() {
    List<BookmarkData> retList = [];
    List<String> bookList = BookUtility.getNameList();

    for (String path in bookList) {
      final File file = File(join(path, "bookmark.isar"));
      if (file.existsSync()) {
        final String bookName = basename(path);
        final BookmarkData bookmarkObject = BookmarkData.load(bookName);
        if (bookmarkObject.isValid) {
          retList.add(bookmarkObject);
        } else {
          bookmarkObject.clear();
        }
      }
    }

    return retList;
  }
}