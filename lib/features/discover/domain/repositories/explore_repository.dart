import '../entities/catalog_feed.dart';

/// An abstract contract for the discovery repository.
///
/// This defines the high-level operations for discovering and searching content.
abstract class ExploreRepository {
  /// Fetches a catalog feed from a given URL.
  Future<CatalogFeed?> browseCatalog(Uri uri);
}
