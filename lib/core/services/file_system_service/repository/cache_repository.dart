part of '../file_system_service.dart';

class CacheRepository extends FileSystemRepository {
  const CacheRepository();

  Future<Directory> get rootDirectory => getApplicationCacheDirectory();

  Future<Directory> get bookLocationDirectory async =>
      createDirectory(join((await rootDirectory).path, 'locations'));
}
