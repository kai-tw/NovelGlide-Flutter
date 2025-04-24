import 'dart:io';

import 'package:path/path.dart';

import '../../utils/file_path.dart';
import '../book_repository.dart';

part 'location_cache.dart';

class CacheRepository {
  CacheRepository._();

  static String get cachePath => FilePath.tempFolder;

  static const LocationCache locationCache = LocationCache();

  static void clear() {
    locationCache.clear();
  }
}
