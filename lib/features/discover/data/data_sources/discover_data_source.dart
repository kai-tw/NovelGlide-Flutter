import '../../domain/entities/catalog_feed.dart';

/// An abstract contract for the discovery data source.
///
/// It defines how to fetch and parse data from a remote source.
abstract class DiscoverDataSource {
  /// Fetches and parses an catalog feed from a URL.
  Future<CatalogFeed?> getCatalogFeed(Uri uri);
}
