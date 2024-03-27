import 'dart:io';

import 'package:collection/collection.dart';

import 'book_object.dart';
import 'file_path.dart';

class BookUtility {
  static List<String> getNameList() {
    final Directory folder = Directory(filePath.libraryRoot);
    folder.createSync(recursive: true);

    final List<String> entries = folder.listSync().whereType<Directory>().map((e) => e.path).toList();
    entries.sort(compareNatural);

    return entries;
  }

  static List<BookObject> getObjectList() {
    return getNameList().map((e) => BookObject.fromName(e)).toList();
  }
}