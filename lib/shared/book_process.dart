import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart';

import 'file_process.dart';

class BookProcess {
  static const String defaultCover = 'assets/images/book_cover_light.jpg';

  static Future<List<BookObject>> getList() async {
    final Directory folder = Directory(await FileProcess.libraryRoot);
    folder.createSync(recursive: true);
    final List<Directory> entries = folder.listSync().whereType<Directory>().toList();
    List<BookObject> list = entries
        .map((item) => BookObject(name: basename(item.path), coverFile: File(join(item.path, 'cover.jpg'))))
        .toList();
    list.sort((BookObject a, BookObject b) {
      return compareNatural(a.name, b.name);
    });
    return list;
  }
}

class BookObject {
  String name;
  File coverFile;

  BookObject({required this.name, required this.coverFile});
}
