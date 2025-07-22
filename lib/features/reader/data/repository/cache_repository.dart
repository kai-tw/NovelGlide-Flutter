import 'dart:io';

import 'package:path/path.dart';

import '../../../../core/domains/file_system_domain/file_system_domain.dart';
import '../../../book_service/book_service.dart';

class LocationCacheRepository {
  LocationCacheRepository._();

  static Future<String> get _rootPath async =>
      (await FileSystemDomain.cache.bookLocationDirectory).path;

  static Future<File> _getTmpFileByPath(String bookPath) async {
    final String relativePath =
        BookService.repository.getRelativePath(bookPath);
    return File(
        join(await _rootPath, '${basenameWithoutExtension(relativePath)}.tmp'));
  }

  /// Store the location to the cache file.
  static Future<void> store(String bookPath, String location) async {
    final File file = await _getTmpFileByPath(bookPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync(location);
  }

  /// Retrieve the location from the cache file.
  static Future<String?> get(String bookPath) async {
    final File file = await _getTmpFileByPath(bookPath);
    if (file.existsSync()) {
      return file.readAsStringSync();
    } else {
      return null;
    }
  }

  /// Delete the location cache file.
  static Future<void> delete(String bookPath) async {
    final File file = await _getTmpFileByPath(bookPath);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  /// Delete all location cache files.
  static Future<void> clear() async {
    final Directory folder = Directory(await _rootPath);
    if (folder.existsSync()) {
      folder.deleteSync(recursive: true);
    }
  }
}
