import 'dart:async';

import '../../domain/entities/catalog_feed.dart';
import '../../domain/repositories/explore_repository.dart';
import '../data_sources/explore_data_source.dart';

/// The concrete implementation of the DiscoverRepository.
class ExploreRepositoryImpl implements ExploreRepository {
  ExploreRepositoryImpl(this._dataSource);

  final ExploreDataSource _dataSource;

  @override
  Future<CatalogFeed?> browseCatalog(Uri uri) {
    return _dataSource.getCatalogFeed(uri);
  }
}
