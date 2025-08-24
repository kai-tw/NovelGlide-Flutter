import '../../domain/entities/catalog_feed.dart';
import '../../domain/repositories/discover_repository.dart';
import '../data_sources/discover_data_source.dart';

/// The concrete implementation of the DiscoverRepository.
class DiscoverRepositoryImpl implements DiscoverRepository {
  DiscoverRepositoryImpl(this._dataSource);

  final DiscoverDataSource _dataSource;

  @override
  Future<CatalogFeed> browseCatalog(Uri uri) async {
    return await _dataSource.getCatalogFeed(uri);
  }

  @override
  Future<CatalogFeed> searchCatalog(String url, String query) async {
    return _dataSource.searchCatalogFeed(url, query);
  }
}
