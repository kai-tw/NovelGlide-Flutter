import '../entities/discover_favorite_catalog_data.dart';

abstract class DiscoverFavoriteRepository {
  /// Send a changing notification to listeners
  Stream<void> get onListChangeStream;

  Future<List<String>> getList();

  Future<void> saveList(List<String> list);

  Future<void> createData(DiscoverFavoriteCatalogData data);

  Future<DiscoverFavoriteCatalogData?> readData(String identifier);

  Future<void> updateData(DiscoverFavoriteCatalogData data);

  Future<void> deleteData(String identifier);

  Future<bool> existsData(String identifier);
}
