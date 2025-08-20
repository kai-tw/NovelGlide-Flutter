import 'package:novel_glide/features/discover/data/models/catalog_feed_model.dart';

import '../../domain/entities/catalog_feed.dart';
import '../../domain/repositories/discover_repository.dart';
import '../data_sources/discover_data_source.dart';

/// The concrete implementation of the DiscoverRepository.
class DiscoverRepositoryImpl implements DiscoverRepository {
  DiscoverRepositoryImpl(this._dataSource);

  final DiscoverDataSource _dataSource;

  @override
  Future<CatalogFeed> browseCatalog(String url) async {
    final CatalogFeedModel feedModel = await _dataSource.getCatalogFeed(url);
    return feedModel.toEntity();
  }

  @override
  Future<CatalogFeed> searchCatalog(String url, String query) async {
    final CatalogFeedModel feedModel =
        await _dataSource.searchCatalogFeed(url, query);
    return feedModel.toEntity();
  }
}
