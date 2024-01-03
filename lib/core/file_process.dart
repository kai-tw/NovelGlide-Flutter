import 'dart:io';
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
    return entries.map((dir) => basename(dir.path)).toList();
  }

  static Future<bool> isBookExists(String name) async {
    final folder = Directory('${await libraryRoot}/$name');
    return folder.existsSync();
  }

  static Future<bool> createBook(String name) async {
    final folder = Directory('${await libraryRoot}/$name');
    folder.createSync(recursive: true);
    return folder.existsSync();
  }

  static Future<bool> deleteBook(String name) async {
    final folder = Directory('${await libraryRoot}/$name');
    if (folder.existsSync()) {
      folder.deleteSync(recursive: true);
    }
    return !folder.existsSync();
  }
}
