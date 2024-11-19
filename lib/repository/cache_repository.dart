import 'dart:io';

import 'package:path/path.dart';

import '../utils/file_path.dart';
import 'book_repository.dart';

class CacheRepository {
  CacheRepository._();

  static String get _cachePath => FilePath.tempFolder;

  /// ===== Location Cache Start =====

  static String get _locationPath => join(_cachePath, 'locations');

  static File _getLocationFile(String bookPath) {
    final relativePath = BookRepository.getRelativePath(bookPath);
    return File(
        join(_locationPath, '${basenameWithoutExtension(relativePath)}.tmp'));
  }

  static void storeLocation(String bookPath, String location) {
    final file = _getLocationFile(bookPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync(location);
  }

  static String? getLocation(String bookPath) {
    final file = _getLocationFile(bookPath);
    if (file.existsSync()) {
      return file.readAsStringSync();
    } else {
      return null;
    }
  }

  static void deleteLocation(String bookPath) {
    final file = _getLocationFile(bookPath);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  static void clearLocation() {
    final folder = Directory(_locationPath);
    if (folder.existsSync()) {
      folder.deleteSync(recursive: true);
    }
  }

  /// ===== Location Cache End =====

  static void clear() {
    clearLocation();
  }
}
