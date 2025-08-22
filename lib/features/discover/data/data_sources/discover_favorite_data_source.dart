import '../../domain/entities/discover_favorite_catalog_data.dart';

abstract class DiscoverFavoriteDataSource {
  Future<List<String>> getList();

  Future<void> saveList(List<String> list);

  Future<void> createData(DiscoverFavoriteCatalogData data);

  Future<DiscoverFavoriteCatalogData?> readData(String identifier);

  Future<void> updateData(DiscoverFavoriteCatalogData data);

  Future<void> deleteData(String identifier);

  Future<bool> existsData(String identifier);
}
