import 'package:novel_glide/features/discover/domain/entities/discover_favorite_catalog_data.dart';

import '../../../../../core/file_system/domain/repositories/json_repository.dart';
import '../../../../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../models/discover_favorite_json_model.dart';
import '../discover_favorite_data_source.dart';

class DiscoverJsonFavoriteDataSourceImpl implements DiscoverFavoriteDataSource {
  DiscoverJsonFavoriteDataSourceImpl(
    this._jsonPathProvider,
    this._jsonRepository,
  );

  final JsonPathProvider _jsonPathProvider;
  final JsonRepository _jsonRepository;

  @override
  Future<List<String>> getList() async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.discoverFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final DiscoverFavoriteJsonModel model =
        DiscoverFavoriteJsonModel.fromJson(jsonValue);

    // Map the list json into the entity.
    return model.identifierList;
  }

  @override
  Future<void> saveList(List<String> list) async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.discoverFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final DiscoverFavoriteJsonModel model =
        DiscoverFavoriteJsonModel.fromJson(jsonValue);

    // Clear the list
    model.identifierList.clear();

    // Convert data into JSON
    model.identifierList.addAll(list);

    // Write file
    await _jsonRepository.writeJson(
      path: jsonPath,
      data: model.toJson(),
    );
  }

  @override
  Future<void> createData(DiscoverFavoriteCatalogData data) async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.discoverFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final DiscoverFavoriteJsonModel model =
        DiscoverFavoriteJsonModel.fromJson(jsonValue);

    if (!model.dataMap.containsKey(data.identifier)) {
      // Data does not exist in the file.
      model.dataMap[data.identifier] = data;

      // Write to file
      await _jsonRepository.writeJson(
        path: jsonPath,
        data: model.toJson(),
      );
    }
  }

  @override
  Future<void> deleteData(String identifier) async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.discoverFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final DiscoverFavoriteJsonModel model =
        DiscoverFavoriteJsonModel.fromJson(jsonValue);

    if (model.dataMap.containsKey(identifier)) {
      // Data exists in the file.
      model.dataMap.remove(identifier);

      // If it exists in the list, also remove it.
      model.identifierList.remove(identifier);

      // Write to file
      await _jsonRepository.writeJson(
        path: jsonPath,
        data: model.toJson(),
      );
    }
  }

  @override
  Future<DiscoverFavoriteCatalogData?> readData(String identifier) async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.discoverFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final DiscoverFavoriteJsonModel model =
        DiscoverFavoriteJsonModel.fromJson(jsonValue);

    // Return the data.
    return model.dataMap[identifier];
  }

  @override
  Future<void> updateData(DiscoverFavoriteCatalogData data) async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.discoverFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final DiscoverFavoriteJsonModel model =
        DiscoverFavoriteJsonModel.fromJson(jsonValue);

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
    final String jsonPath = await _jsonPathProvider.discoverFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final DiscoverFavoriteJsonModel model =
        DiscoverFavoriteJsonModel.fromJson(jsonValue);

    return model.dataMap.containsKey(identifier);
  }
}
