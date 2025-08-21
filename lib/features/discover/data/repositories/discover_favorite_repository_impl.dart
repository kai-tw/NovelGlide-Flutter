import 'package:novel_glide/features/discover/domain/entities/discover_favorite_catalog_data.dart';

import '../../domain/repositories/discover_favorite_repository.dart';
import '../data_sources/discover_favorite_data_source.dart';

class DiscoverFavoriteRepositoryImpl implements DiscoverFavoriteRepository {
  DiscoverFavoriteRepositoryImpl(this._dataSource);

  final DiscoverFavoriteDataSource _dataSource;

  @override
  Future<List<DiscoverFavoriteCatalogData>> getFavoriteList() {
    return _dataSource.getFavoriteList();
  }
}
