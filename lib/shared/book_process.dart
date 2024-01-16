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
    List<BookObject> list = entries.map((item) => BookObject.fromPath(item.path)).toList();
    list.sort((BookObject a, BookObject b) {
      return compareNatural(a.name, b.name);
    });
    return list;
  }

  static Future<bool> isExists(String name) async {
    final folder = Directory(join(await FileProcess.libraryRoot, name));
    return folder.existsSync();
  }

  static Future<bool> create(BookObject bookObject) async {
    if (bookObject.name == '') {
      return false;
    }
    bool isSuccess = true;
    final folder = Directory(join(await FileProcess.libraryRoot, bookObject.name));
    folder.createSync(recursive: true);
    isSuccess = isSuccess && folder.existsSync();
    if (bookObject.coverFile != null) {
      File coverImage = bookObject.coverFile!.copySync(join(folder.path, 'cover.jpg'));
      isSuccess = isSuccess && coverImage.existsSync();
    }
    return isSuccess;
  }
}

class BookObject {
  String name = '';
  File? coverFile;

  BookObject();
  BookObject.fromPath(String path) {
    name = basename(path);
    coverFile = File(join(path, 'cover.jpg'));
  }
}
