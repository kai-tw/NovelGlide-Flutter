part of '../file_system_service.dart';

class CacheRepository {
  const CacheRepository();

  Future<Directory> get rootDirectory => getApplicationCacheDirectory();

  Future<Directory> get bookLocationDirectory async =>
      Directory(join((await rootDirectory).path, 'locations'));
}
