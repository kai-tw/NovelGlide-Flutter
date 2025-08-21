import 'package:path/path.dart';

import '../../domain/repositories/app_path_provider.dart';
import '../../domain/repositories/json_path_provider.dart';

class JsonPathProviderImpl extends JsonPathProvider {
  JsonPathProviderImpl(this._pathProvider);

  final AppPathProvider _pathProvider;

  @override
  Future<String> get bookmarkJsonPath async {
    final String dataPath = await _pathProvider.dataPath;
    return join(dataPath, 'bookmark.json');
  }

  @override
  Future<String> get collectionJsonPath async {
    final String dataPath = await _pathProvider.dataPath;
    return join(dataPath, 'collection.json');
  }

  @override
  Future<String> get discoverFavoriteJsonPath async {
    final String dataPath = await _pathProvider.dataPath;
    return join(dataPath, 'discover_favorite.json');
  }
}
