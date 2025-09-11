import '../entities/explore_favorite_catalog_data.dart';

abstract class ExploreFavoriteRepository {
  /// Send a changing notification to listeners
  Stream<void> get onListChangeStream;

  Future<List<String>> getList();

  Future<void> saveList(List<String> list);

  Future<void> createData(ExploreFavoriteCatalogData data);

  Future<ExploreFavoriteCatalogData?> readData(String identifier);

  Future<void> updateData(ExploreFavoriteCatalogData data);

  Future<void> deleteData(String identifier);

  Future<bool> existsData(String identifier);
}
