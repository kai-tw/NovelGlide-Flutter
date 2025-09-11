import '../../domain/entities/explore_favorite_catalog_data.dart';

abstract class ExploreFavoriteDataSource {
  Future<List<String>> getList();

  Future<void> saveList(List<String> list);

  Future<void> createData(ExploreFavoriteCatalogData data);

  Future<ExploreFavoriteCatalogData?> readData(String identifier);

  Future<void> updateData(ExploreFavoriteCatalogData data);

  Future<void> deleteData(String identifier);

  Future<bool> existsData(String identifier);
}
