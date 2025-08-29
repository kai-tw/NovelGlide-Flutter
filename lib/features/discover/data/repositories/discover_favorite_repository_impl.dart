import 'dart:async';

import 'package:novel_glide/features/discover/domain/entities/discover_favorite_catalog_data.dart';

import '../../domain/repositories/discover_favorite_repository.dart';
import '../data_sources/discover_favorite_data_source.dart';

class DiscoverFavoriteRepositoryImpl implements DiscoverFavoriteRepository {
  DiscoverFavoriteRepositoryImpl(this._dataSource);

  final DiscoverFavoriteDataSource _dataSource;

  /// Stream controller
  final StreamController<void> _onListChangeController =
      StreamController<void>.broadcast();

  @override
  Stream<void> get onListChangeStream => _onListChangeController.stream;

  @override
  Future<List<String>> getList() {
    return _dataSource.getList();
  }

  @override
  Future<void> saveList(List<String> list) async {
    await _dataSource.saveList(list);

    // Send a notification
    _onListChangeController.add(null);
  }

  @override
  Future<void> createData(DiscoverFavoriteCatalogData data) async {
    await _dataSource.createData(data);
  }

  @override
  Future<DiscoverFavoriteCatalogData?> readData(String identifier) {
    return _dataSource.readData(identifier);
  }

  @override
  Future<void> updateData(DiscoverFavoriteCatalogData data) async {
    await _dataSource.updateData(data);

    // Send a notification
    _onListChangeController.add(null);
  }

  @override
  Future<void> deleteData(String identifier) async {
    await _dataSource.deleteData(identifier);

    // Send a notification
    _onListChangeController.add(null);
  }

  @override
  Future<bool> existsData(String identifier) {
    return _dataSource.existsData(identifier);
  }
}
