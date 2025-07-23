part of '../collection_service.dart';

class CollectionRepository {
  Future<String> get jsonFileName async => (await jsonFile).baseName;

  Future<JsonFileModel> get jsonFile async {
    return FileSystemDomain.json.getJsonFile(
      await FileSystemDomain.document.collectionJsonFile,
    );
  }

  /// Create a new empty collection with a unique ID.
  Future<void> create(String name) async {
    final JsonFileModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    String id;

    do {
      id = Random().nextString(10);
    } while (jsonData.containsKey(id));

    jsonData[id] = CollectionData(id, name, const <String>[]).toJson();
    jsonFile.data = jsonData;
  }

  Future<CollectionData> get(String id) async {
    final JsonFileModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    if (jsonData.containsKey(id)) {
      return CollectionData.fromJson(jsonData[id]!);
    } else {
      return CollectionData(id, id, const <String>[]);
    }
  }

  /// Retrieve a list of all [CollectionData] instances.
  Future<List<CollectionData>> getList() async {
    final JsonFileModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    return jsonData.keys
        .map((String key) => CollectionData.fromJson(jsonData[key]!))
        .toList();
  }

  /// Save the current [CollectionData] instance to the JSON file.
  Future<void> save(CollectionData data) async {
    final JsonFileModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    data.pathList = data.pathList
        .toSet()
        .map<String>((String e) => BookService.repository.getRelativePath(e))
        .toList();
    jsonData[data.id] = data.toJson();
    jsonFile.data = jsonData;
  }

  /// Delete the current [CollectionData] instance from the JSON file.
  Future<void> delete(CollectionData data) async {
    final JsonFileModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    jsonData.remove(data.id);
    jsonFile.data = jsonData;
  }

  /// Delete the book_service from the collection.
  Future<void> deleteBook(String path, String id) async {
    final JsonFileModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    final String relativePath = BookService.repository.getRelativePath(path);
    if (jsonData[id] != null) {
      final CollectionData data = CollectionData.fromJson(jsonData[id]!);
      data.pathList.remove(relativePath);
      jsonData[id] = data.toJson();
      jsonFile.data = jsonData;
    }
  }

  /// Delete the book_service from all collections.
  Future<void> deleteByPath(String path) async {
    final List<CollectionData> list = await getList();
    final Iterable<CollectionData> collectionList = list.where(
        (CollectionData e) =>
            e.pathList.contains(BookService.repository.getRelativePath(path)));
    for (CollectionData data in collectionList) {
      deleteBook(path, data.id);
    }
  }

  /// Reset the collection repository.
  Future<void> reset() async {
    (await jsonFile).clear();
  }
}
