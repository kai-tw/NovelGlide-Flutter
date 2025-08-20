import '../../domain/entities/catalog_feed.dart';

/// An abstract contract for the discovery data source.
///
/// It defines how to fetch and parse data from a remote source.
abstract class DiscoverDataSource {
  /// Fetches and parses an OPDS catalog feed from a URL.
  Future<CatalogFeed> getCatalogFeed(String url);

  /// Searches a catalog for publications using a query.
  Future<CatalogFeed> searchCatalogFeed(String url, String query);
}
