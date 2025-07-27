part of '../collection_service.dart';

typedef CollectionRepositoryJsonMap = Map<String, CollectionData>;

class CollectionRepository {
  Future<String> get jsonFileName async => (await jsonFile).baseName;

  Future<JsonFileMetaModel> get jsonFile async {
    return FileSystemService.json.getJsonFile(
      await FileSystemService.document.collectionJsonFile,
    );
  }

  Future<CollectionRepositoryJsonMap> get jsonData async {
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    return jsonFile.data.map((String key, dynamic value) {
      return MapEntry<String, CollectionData>(
          key, CollectionData.fromJson(value));
    });
  }

  /// Create a new empty collection with a unique ID.
  Future<CollectionData> create([String? name]) async {
    // Load json data;
    final CollectionRepositoryJsonMap jsonData = await this.jsonData;

    // Create a new id
    String id;

    // Randomly generate a new unique id
    do {
      id = Random().nextString(10);
    } while (jsonData.containsKey(id));

    // Save to json file
    final CollectionData data =
        CollectionData(id, name ?? id, const <String>[]);
    save(data);
    return data;
  }

  Future<CollectionData> getDataById(String id) async {
    // Load json data;
    final CollectionRepositoryJsonMap jsonData = await this.jsonData;

    // Return the data, or create a new one if it doesn't exist
    return jsonData[id] ?? await create();
  }

  /// Retrieve a list of all [CollectionData] instances.
  Future<List<CollectionData>> getList() async {
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    return jsonData.keys
        .map((String key) => CollectionData.fromJson(jsonData[key]!))
        .toList();
  }

  /// Save the current [CollectionData] instance to the JSON file.
  Future<void> save(CollectionData data) async {
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;

    // Convert the pathList to relative paths.
    for (int i = 0; i < data.pathList.length; i++) {
      data.pathList[i] =
          await BookService.repository.getRelativePath(data.pathList[i]);
    }

    // Remove duplicates.
    data.pathList = data.pathList.toSet().toList();

    // Save the data.
    jsonData[data.id] = data.toJson();
    jsonFile.data = jsonData;
  }

  /// Delete the current [CollectionData] instance from the JSON file.
  Future<void> deleteByData(CollectionData data) async {
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    jsonData.remove(data.id);
    jsonFile.data = jsonData;
  }

  /// Delete the book from the collection.
  Future<void> deleteBookFromSingle(String path, String id) async {
    // Load json file
    final JsonFileMetaModel jsonFile = await this.jsonFile;

    // Load json data
    final Map<String, dynamic> jsonData = jsonFile.data;

    if (jsonData.containsKey(id)) {
      // Get relative path
      final String relativePath =
          await BookService.repository.getRelativePath(path);

      // Remove the path from the collection
      final CollectionData data = CollectionData.fromJson(jsonData[id]!);
      data.pathList.remove(relativePath);
      save(data);
    }
  }

  /// Delete the book from all collections.
  Future<void> deleteBookFromAll(String path) async {
    // Get the list of collection data
    final List<CollectionData> list = await getList();

    // Remove the book through each collection
    for (CollectionData data in list) {
      await deleteBookFromSingle(path, data.id);
    }
  }

  /// Reset the collection repository.
  Future<void> reset() async {
    // Clear the content of json file
    (await jsonFile).clear();
  }
}
