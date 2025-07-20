part of '../collection_service.dart';

class CollectionRepository {
  CollectionRepository();

  String jsonFileName = 'collection.json';

  String get jsonPath => join(FilePath.dataRoot, jsonFileName);

  File get jsonFile {
    final File file = File(jsonPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  /// JSON data getter
  Map<String, dynamic> get jsonData => JsonUtils.fromFile(jsonFile);

  /// JSON data setter
  set jsonData(Map<String, dynamic> json) => jsonFile.writeAsStringSync(jsonEncode(json));

  /// Create a new empty collection with a unique ID.
  void create(String name) {
    final Map<String, dynamic> data = jsonData;
    String id;

    do {
      id = Random().nextString(10);
    } while (data.containsKey(id));

    data[id] = CollectionData(id, name, const <String>[]).toJson();
    jsonData = data;
  }

  CollectionData get(String id) {
    if (jsonData.containsKey(id)) {
      return CollectionData.fromJson(jsonData[id]!);
    } else {
      return CollectionData(id, id, const <String>[]);
    }
  }

  /// Retrieve a list of all [CollectionData] instances.
  List<CollectionData> getList() {
    final List<CollectionData> list = <CollectionData>[];

    for (String key in jsonData.keys) {
      list.add(CollectionData.fromJson(jsonData[key]!));
    }

    return list;
  }

  /// Save the current [CollectionData] instance to the JSON file.
  void save(CollectionData data) {
    final Map<String, dynamic> json = jsonData;
    data.pathList = data.pathList.toSet().map<String>((String e) => BookService.repository.getRelativePath(e)).toList();
    json[data.id] = data.toJson();
    jsonData = json;
  }

  /// Delete the current [CollectionData] instance from the JSON file.
  void delete(CollectionData data) {
    final Map<String, dynamic> json = jsonData;
    json.remove(data.id);
    jsonData = json;
  }

  /// Delete the book_service from the collection.
  void deleteBook(String path, String id) {
    final String relativePath = BookService.repository.getRelativePath(path);
    final Map<String, dynamic> json = jsonData;
    if (json[id] != null) {
      final CollectionData data = CollectionData.fromJson(json[id]!);
      data.pathList.remove(relativePath);
      json[id] = data.toJson();
      jsonData = json;
    }
  }

  /// Delete the book_service from all collections.
  void deleteByPath(String path) {
    final Iterable<CollectionData> collectionList =
        getList().where((CollectionData e) => e.pathList.contains(BookService.repository.getRelativePath(path)));
    for (CollectionData data in collectionList) {
      deleteBook(path, data.id);
    }
  }

  /// Reset the collection repository.
  void reset() => jsonData = <String, dynamic>{};
}
