part of '../file_system_domain.dart';

class CacheDirectory {
  CacheDirectory();

  Future<Directory> get rootDirectory => getApplicationCacheDirectory();

  Future<Directory> get bookLocationDirectory async =>
      Directory(join((await rootDirectory).path, 'locations'));
}
