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
    final Directory folder = Directory(join(await supportFolder, 'Library'));
    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }
    return folder.path;
  }

  static Future<String> get hiveRoot async {
    final Directory folder = Directory(join(await supportFolder, 'Hive'));
    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }
    return folder.path;
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
      final oldFolder = Directory(join(await libraryRoot, item));
      final newFolder = Directory(join(await libraryRoot, item.replaceAll(pattern, newName)));
      oldFolder.renameSync(newFolder.path);
      isSuccess = isSuccess && newFolder.existsSync();
    }
    return isSuccess;
  }

  static Future<bool> deleteBook(String name) async {
    if (name == '') {
      return false;
    }
    final folder = Directory(join(await libraryRoot, name));
    if (folder.existsSync()) {
      folder.deleteSync(recursive: true);
    }
    return !folder.existsSync();
  }
}