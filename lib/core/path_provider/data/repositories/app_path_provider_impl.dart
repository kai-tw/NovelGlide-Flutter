import 'dart:io';

import 'package:path/path.dart';

import '../../domain/repositories/app_path_provider.dart';
import '../data_sources/app_path_provider_data_source.dart';

class AppPathProviderImpl extends AppPathProvider {
  AppPathProviderImpl(this._localDataSource);

  final AppPathProviderDataSource _localDataSource;

  /// ========== Document Directories ==========
  @override
  Future<String> get documentPath => _localDataSource.documentPath;

  @override
  Future<String> get dataPath async =>
      _ensuredCreated(join(await documentPath, 'Data'));

  @override
  Future<String> get libraryPath async =>
      _ensuredCreated(join(await documentPath, 'Library'));

  /// ========== Cache Directories ==========

  @override
  Future<String> get cachePath async => _localDataSource.cachePath;

  @override
  Future<String> get bookLocationCachePath async =>
      _ensuredCreated(join(await cachePath, 'locations'));

  /// ========== Temporary Directories ==========

  @override
  Future<String> get tempPath async => _localDataSource.tempPath;

  /// ========== Utilities ==========

  String _ensuredCreated(String path) {
    final Directory directory = Directory(path);

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    return directory.path;
  }
}
