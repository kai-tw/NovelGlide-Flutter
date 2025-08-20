import '../models/catalog_feed_model.dart';

/// An abstract contract for the discovery data source.
///
/// It defines how to fetch and parse data from a remote source.
abstract class DiscoverDataSource {
  /// Fetches and parses an OPDS catalog feed from a URL.
  Future<CatalogFeedModel> getCatalogFeed(String url);

  /// Searches a catalog for publications using a query.
  Future<CatalogFeedModel> searchCatalogFeed(String url, String query);
}
