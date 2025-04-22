import 'dart:convert';
import 'dart:io';

import '../data_model/collection_data.dart';
import '../utils/json_utils.dart';
import '../utils/random_utils.dart';
import 'book_repository.dart';
import 'repository_interface.dart';

class CollectionRepository {
  static String jsonFileName = 'collection.json';

  static String get jsonPath => RepositoryInterface.getJsonPath(jsonFileName);

  static File get jsonFile => RepositoryInterface.getJsonFile(jsonPath);

  /// JSON data getter
  static Map<String, dynamic> get jsonData => JsonUtils.fromFile(jsonFile);

  /// JSON data setter
  static set jsonData(Map<String, dynamic> json) =>
      jsonFile.writeAsStringSync(jsonEncode(json));

  /// Create a new empty collection with a unique ID.
  static void create(String name) {
    final data = jsonData;
    String id = RandomUtils.getRandomString(10);

    while (data.containsKey(id)) {
      id = RandomUtils.getRandomString(10);
    }

    data[id] = CollectionData(id, name, const <String>[]).toJson();
    jsonData = data;
  }

  static CollectionData get(String id) {
    if (jsonData.containsKey(id)) {
      return CollectionData.fromJson(jsonData[id]!);
    } else {
      return CollectionData(id, id, const <String>[]);
    }
  }

  /// Retrieve a list of all [CollectionData] instances.
  static List<CollectionData> getList() {
    List<CollectionData> list = [];

    for (var key in jsonData.keys) {
      list.add(CollectionData.fromJson(jsonData[key]!));
    }

    return list;
  }

  /// Save the current [CollectionData] instance to the JSON file.
  static void save(CollectionData data) {
    final json = jsonData;
    data.pathList = data.pathList
        .toSet()
        .map<String>((e) => BookRepository.getRelativePath(e))
        .toList();
    json[data.id] = data.toJson();
    jsonData = json;
  }

  /// Delete the current [CollectionData] instance from the JSON file.
  static void delete(CollectionData data) {
    final json = jsonData;
    json.remove(data.id);
    jsonData = json;
  }

  /// Delete the book from the collection.
  static void deleteBook(String path, String id) {
    final relativePath = BookRepository.getRelativePath(path);
    final json = jsonData;
    if (json[id] != null) {
      final data = CollectionData.fromJson(json[id]!);
      data.pathList.remove(relativePath);
      json[id] = data.toJson();
      jsonData = json;
    }
  }

  /// Delete the book from all collections.
  static void deleteByPath(String path) {
    final collectionList = getList().where(
        (e) => e.pathList.contains(BookRepository.getRelativePath(path)));
    for (CollectionData data in collectionList) {
      deleteBook(path, data.id);
    }
  }

  /// Reset the collection repository.
  static void reset() => jsonData = {};
}
