import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

enum FileProcessType {folder, file}

class FileProcess {
  /// Paths initialization.
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
      _createHiveFolders(folder.path);
    }
    return folder.path;
  }

  static List<String> hiveFolderList = ['reader'];

  static void _createHiveFolders(String rootPath) {
    for (var item in hiveFolderList) {
      Directory itemDir = Directory(join(rootPath, item));
      if (!itemDir.existsSync()) {
        itemDir.create();
      }
    }
  }
}