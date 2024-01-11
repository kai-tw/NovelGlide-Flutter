import 'dart:io';
import 'package:collection/collection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

enum FileProcessType {folder, file}

class FileProcess {
  // Paths initialization.
  static Future<String> get supportFolder async {
    final folder = await getApplicationSupportDirectory();
    return folder.path;
  }

  static Future<String> get documentFolder async {
    final folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }

  static Future<String> get cacheFolder async {
    final folder = await getApplicationCacheDirectory();
    return folder.path;
  }

  static Future<String> get tempFolder async {
    final folder = await getTemporaryDirectory();
    return folder.path;
  }

  static Future<String> get libraryRoot async {
    final folder = await supportFolder;
    return '$folder/Library';
  }

  static Future<List<String>> getLibraryBookList() async {
    final folder = Directory(await libraryRoot);
    folder.createSync(recursive: true);
    final entries = folder.listSync().whereType<Directory>().toList();
    List<String> list = entries.map((dir) => basename(dir.path)).toList();
    list.sort(compareNatural);
    return list;
  }

  static Future<bool> isBookExists(String name) async {
    final folder = Directory('${await libraryRoot}/$name');
    return folder.existsSync();
  }

  static Future<bool> createBook(String name) async {
    if (name == '') {
      return false;
    }
    final folder = Directory('${await libraryRoot}/$name');
    folder.createSync(recursive: true);
    return folder.existsSync();
  }

  static Future<bool> renameBook(String oldName, String newName) async {
    if (oldName == '' || newName == '') {
      return false;
    }
    if (oldName == newName) {
      return true;
    }
    final oldFolder = Directory('${await libraryRoot}/$oldName');
    final newFolder = Directory('${await libraryRoot}/$newName');
    oldFolder.renameSync(newFolder.path);
    return newFolder.existsSync();
  }

  static Future<bool> renameBookBatch(Set<String> selectedBooks, String pattern, String newName) async {
    if (pattern == '' || selectedBooks.isEmpty) {
      return false;
    }
    if (pattern == newName) {
      return true;
    }
    bool isSuccess = true;
    for (String item in selectedBooks) {
      final oldFolder = Directory('${await libraryRoot}/$item');
      final newFolder = Directory('${await libraryRoot}/${item.replaceAll(pattern, newName)}');
      oldFolder.renameSync(newFolder.path);
      isSuccess = isSuccess && newFolder.existsSync();
    }
    return isSuccess;
  }

  static Future<bool> deleteBook(String name) async {
    if (name == '') {
      return false;
    }
    final folder = Directory('${await libraryRoot}/$name');
    if (folder.existsSync()) {
      folder.deleteSync(recursive: true);
    }
    return !folder.existsSync();
  }
}
