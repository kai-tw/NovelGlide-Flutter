import 'dart:async';

import '../../domain/entities/catalog_feed.dart';
import '../../domain/repositories/discover_repository.dart';
import '../data_sources/discover_data_source.dart';

/// The concrete implementation of the DiscoverRepository.
class DiscoverRepositoryImpl implements DiscoverRepository {
  DiscoverRepositoryImpl(this._dataSource);

  final DiscoverDataSource _dataSource;

  @override
  Future<CatalogFeed> browseCatalog(Uri uri) {
    return _dataSource.getCatalogFeed(uri);
  }
}
