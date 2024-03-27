import 'dart:io';

import 'package:path/path.dart';

import 'book_utility.dart';
import 'bookmark_object.dart';

class BookmarkUtility {
  static List<BookmarkObject> getList() {
    List<BookmarkObject> retList = [];
    List<String> bookList = BookUtility.getNameList();

    for (String path in bookList) {
      final File file = File(join(path, "bookmark.isar"));
      if (file.existsSync()) {
        final String bookName = basename(path);
        final BookmarkObject bookmarkObject = BookmarkObject.load(bookName);
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