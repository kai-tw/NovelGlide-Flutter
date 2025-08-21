import '../../domain/entities/discover_favorite_catalog_data.dart';

abstract class DiscoverFavoriteDataSource {
  Future<List<DiscoverFavoriteCatalogData>> getFavoriteList();
}
