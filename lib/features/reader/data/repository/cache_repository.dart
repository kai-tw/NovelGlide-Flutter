import 'dart:io';

import 'package:path/path.dart';

import '../../../../core/services/file_path.dart';
import '../../../book_service/book_service.dart';

class LocationCacheRepository {
  LocationCacheRepository._();

  static String get _rootPath => join(FilePath.cacheRoot, 'locations');

  static File _getTmpFileByPath(String bookPath) {
    final String relativePath = BookService.repository.getRelativePath(bookPath);
    return File(join(_rootPath, '${basenameWithoutExtension(relativePath)}.tmp'));
  }

  /// Store the location to the cache file.
  static void store(String bookPath, String location) {
    final File file = _getTmpFileByPath(bookPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync(location);
  }

  /// Retrieve the location from the cache file.
  static String? get(String bookPath) {
    final File file = _getTmpFileByPath(bookPath);
    if (file.existsSync()) {
      return file.readAsStringSync();
    } else {
      return null;
    }
  }

  /// Delete the location cache file.
  static void delete(String bookPath) {
    final File file = _getTmpFileByPath(bookPath);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  /// Delete all location cache files.
  static void clear() {
    final Directory folder = Directory(_rootPath);
    if (folder.existsSync()) {
      folder.deleteSync(recursive: true);
    }
  }
}
