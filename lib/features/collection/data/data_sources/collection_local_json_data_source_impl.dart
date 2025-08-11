import 'dart:math';

import '../../../../core/file_system/domain/repositories/json_repository.dart';
import '../../../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../../../core/utils/random_extension.dart';
import '../../domain/entities/collection_data.dart';
import 'collection_local_json_data_source.dart';

class CollectionLocalJsonDataSourceImpl extends CollectionLocalJsonDataSource {
  CollectionLocalJsonDataSourceImpl(
    this._jsonPathProvider,
    this._jsonRepository,
  );

  final JsonPathProvider _jsonPathProvider;
  final JsonRepository _jsonRepository;

  @override
  Future<CollectionData> createData([String? name]) async {
    // Load json data
    final Map<String, dynamic> json = await _loadData();

    // Randomly generate a new unique id
    String id;
    do {
      id = Random().nextString(10);
    } while (json.containsKey(id));

    // Create a new collection data
    final CollectionData data = CollectionData(
      id: id,
      name: name ?? id,
      pathList: const <String>[],
    );

    // Save to json file
    json[data.id] = <String, dynamic>{
      'id': data.id,
      'name': data.name,
      'pathList': data.pathList,
    };
    await _writeData(json);

    return data;
  }

  @override
  Future<void> deleteData(Set<CollectionData> dataSet) async {
    // Load json data
    final Map<String, dynamic> json = await _loadData();

    // Remove by id
    for (CollectionData data in dataSet) {
      json.remove(data.id);
    }

    // Write file
    await _writeData(json);
  }

  @override
  Future<CollectionData> getDataById(String id) async {
    // Load json data
    final Map<String, dynamic> json = await _loadData();

    // Return the data, or create a new one if it doesn't exist
    return json.containsKey(id)
        ? CollectionData(
            id: json[id]['id'],
            name: json[id]['name'],
            pathList: List<String>.from(json[id]['pathList']),
          )
        : CollectionData(
            id: id,
            name: id,
            pathList: const <String>[],
          );
  }

  @override
  Future<List<CollectionData>> getList() async {
    // Load json data
    final Map<String, dynamic> json = await _loadData();

    // Create the list
    return json.keys
        .map((String key) => CollectionData(
              id: json[key]['id'],
              name: json[key]['name'],
              pathList: List<String>.from(json[key]['pathList']),
            ))
        .toList();
  }

  @override
  Future<void> updateData(Set<CollectionData> dataSet) async {
    // Load json data
    final Map<String, dynamic> json = await _loadData();

    for (CollectionData data in dataSet) {
      json[data.id] = <String, dynamic>{
        'id': data.id,
        'name': data.name,
        'pathList': data.pathList,
      };
    }

    // Save to file
    await _writeData(json);
  }

  @override
  Future<void> reset() async {
    return _writeData(<String, dynamic>{});
  }

  /// ========== Utilities ==========

  /// Load json data
  Future<Map<String, dynamic>> _loadData() async {
    final String jsonPath = await _jsonPathProvider.collectionJsonPath;
    return _jsonRepository.readJson(path: jsonPath);
  }

  /// Write to file
  Future<void> _writeData(Map<String, dynamic> json) async {
    final String jsonPath = await _jsonPathProvider.collectionJsonPath;
    await _jsonRepository.writeJson(path: jsonPath, data: json);
  }
}
