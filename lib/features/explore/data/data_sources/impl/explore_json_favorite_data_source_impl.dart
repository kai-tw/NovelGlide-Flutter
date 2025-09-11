import 'package:novel_glide/features/explore/domain/entities/explore_favorite_catalog_data.dart';

import '../../../../../core/file_system/domain/repositories/json_repository.dart';
import '../../../../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../models/explore_favorite_json_model.dart';
import '../explore_favorite_data_source.dart';

class ExploreJsonFavoriteDataSourceImpl implements ExploreFavoriteDataSource {
  ExploreJsonFavoriteDataSourceImpl(
    this._jsonPathProvider,
    this._jsonRepository,
  );

  final JsonPathProvider _jsonPathProvider;
  final JsonRepository _jsonRepository;

  @override
  Future<List<String>> getList() async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.exploreFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final ExploreFavoriteJsonModel model =
        ExploreFavoriteJsonModel.fromJson(jsonValue);

    // Map the list json into the entity.
    return List<String>.from(model.identifierList);
  }

  @override
  Future<void> saveList(List<String> list) async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.exploreFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final ExploreFavoriteJsonModel model =
        ExploreFavoriteJsonModel.fromJson(jsonValue);

    final List<String> identifierList = List<String>.from(model.identifierList);

    // Clear the list
    identifierList.clear();

    // Convert data into JSON
    identifierList.addAll(list);

    // Write file
    await _jsonRepository.writeJson(
      path: jsonPath,
      data: model.copyWith(identifierList: identifierList).toJson(),
    );
  }

  @override
  Future<void> createData(ExploreFavoriteCatalogData data) async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.exploreFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final ExploreFavoriteJsonModel model =
        ExploreFavoriteJsonModel.fromJson(jsonValue);

    // Copy for modification.
    final Map<String, ExploreFavoriteCatalogData> dataMap =
        Map<String, ExploreFavoriteCatalogData>.from(model.dataMap);

    if (!dataMap.containsKey(data.identifier)) {
      // Data does not exist in the file.
      dataMap[data.identifier] = data;

      // Write to file
      await _jsonRepository.writeJson(
        path: jsonPath,
        data: model.copyWith(dataMap: dataMap).toJson(),
      );
    }
  }

  @override
  Future<void> deleteData(String identifier) async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.exploreFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final ExploreFavoriteJsonModel model =
        ExploreFavoriteJsonModel.fromJson(jsonValue);

    if (model.dataMap.containsKey(identifier)) {
      // Data exists in the file.
      model.dataMap.remove(identifier);
    }

    // If it exists in the list, also remove it.
    model.identifierList.remove(identifier);

    // Write to file
    await _jsonRepository.writeJson(
      path: jsonPath,
      data: model.toJson(),
    );
  }

  @override
  Future<ExploreFavoriteCatalogData?> readData(String identifier) async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.exploreFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final ExploreFavoriteJsonModel model =
        ExploreFavoriteJsonModel.fromJson(jsonValue);

    // Return the data.
    return model.dataMap[identifier];
  }

  @override
  Future<void> updateData(ExploreFavoriteCatalogData data) async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.exploreFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final ExploreFavoriteJsonModel model =
        ExploreFavoriteJsonModel.fromJson(jsonValue);

    if (model.dataMap.containsKey(data.identifier)) {
      // Data exists in the file.
      model.dataMap[data.identifier] = data;

      // Write to file
      await _jsonRepository.writeJson(
        path: jsonPath,
        data: model.toJson(),
      );
    }
  }

  @override
  Future<bool> existsData(String identifier) async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.exploreFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final ExploreFavoriteJsonModel model =
        ExploreFavoriteJsonModel.fromJson(jsonValue);

    return model.dataMap.containsKey(identifier);
  }
}
