import '../entities/discover_favorite_catalog_data.dart';

abstract class DiscoverFavoriteRepository {
  Future<List<DiscoverFavoriteCatalogData>> getFavoriteList();
}
