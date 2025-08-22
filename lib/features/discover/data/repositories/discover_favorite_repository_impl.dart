import 'package:novel_glide/features/discover/domain/entities/discover_favorite_catalog_data.dart';

import '../../domain/repositories/discover_favorite_repository.dart';
import '../data_sources/discover_favorite_data_source.dart';

class DiscoverFavoriteRepositoryImpl implements DiscoverFavoriteRepository {
  DiscoverFavoriteRepositoryImpl(this._dataSource);

  final DiscoverFavoriteDataSource _dataSource;

  @override
  Future<List<String>> getList() {
    return _dataSource.getList();
  }

  @override
  Future<void> saveList(List<String> list) {
    return _dataSource.saveList(list);
  }

  @override
  Future<void> createData(DiscoverFavoriteCatalogData data) {
    return _dataSource.createData(data);
  }

  @override
  Future<DiscoverFavoriteCatalogData?> readData(String identifier) {
    return _dataSource.readData(identifier);
  }

  @override
  Future<void> updateData(DiscoverFavoriteCatalogData data) {
    return _dataSource.updateData(data);
  }

  @override
  Future<void> deleteData(String identifier) {
    return _dataSource.deleteData(identifier);
  }

  @override
  Future<bool> existsData(String identifier) {
    return _dataSource.existsData(identifier);
  }
}
