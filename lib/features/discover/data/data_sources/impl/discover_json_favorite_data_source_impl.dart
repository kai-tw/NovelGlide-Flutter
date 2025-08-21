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
  Future<List<DiscoverFavoriteCatalogData>> getFavoriteList() async {
    // Read the json contents.
    final String jsonPath = await _jsonPathProvider.discoverFavoriteJsonPath;
    final Map<String, dynamic> jsonValue = await _jsonRepository.readJson(
      path: jsonPath,
    );

    // Initialize the data model.
    final DiscoverFavoriteJsonModel model =
        DiscoverFavoriteJsonModel.fromJson(jsonValue);

    // Map the list json into the entity.
    return model.catalogList
        .map((Map<String, dynamic> item) => DiscoverFavoriteCatalogData(
              name: item['name'],
              uri: Uri.parse(item['uri']),
            ))
        .toList();
  }
}
