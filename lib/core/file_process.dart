import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileProcess {
  static Future<String> get _supportFolder async {
    final folder = await getApplicationSupportDirectory();
    return folder.path;
  }
  static Future<String> get _documentFolder async {
    final folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }
  static Future<String> get _cacheFolder async {
    final folder = await getApplicationCacheDirectory();
    return folder.path;
  }
  static Future<String> get _tempFolder async {
    final folder = await getTemporaryDirectory();
    return folder.path;
  }

  static Future<String> get() async {
    String path = await _cacheFolder;
    return path;
  }
}