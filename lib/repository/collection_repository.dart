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

  static Map<String, dynamic> getJsonData() => JsonUtils.fromFile(jsonFile);

  /// Creates a new empty collection with a unique ID.
  static void create(String name) {
    final data = getJsonData();
    String id = RandomUtils.getRandomString(10);

    while (data.containsKey(id)) {
      id = RandomUtils.getRandomString(10);
    }

    data[id] = CollectionData(id, name, const <String>[]).toJson();
    jsonFile.writeAsStringSync(jsonEncode(data));
  }

  static CollectionData get(String id) {
    final data = getJsonData();
    if (data.containsKey(id)) {
      return CollectionData.fromJson(data[id]!);
    } else {
      return CollectionData(id, id, const <String>[]);
    }
  }

  /// Retrieves a list of all [CollectionData] instances.
  static List<CollectionData> getList() {
    final data = getJsonData();
    List<CollectionData> list = [];

    for (var key in data.keys) {
      list.add(CollectionData.fromJson(data[key]!));
    }

    return list;
  }

  /// Saves the current [CollectionData] instance to the JSON file.
  static void save(CollectionData data) {
    final json = getJsonData();
    data.pathList = data.pathList
        .toSet()
        .map<String>((e) => BookRepository.getRelativePath(e))
        .toList();
    json[data.id] = data.toJson();
    jsonFile.writeAsStringSync(jsonEncode(json));
  }

  /// Deletes the current [CollectionData] instance from the JSON file.
  static void delete(CollectionData data) {
    final json = getJsonData();
    json.remove(data.id);
    jsonFile.writeAsStringSync(jsonEncode(json));
  }

  /// Deletes the book from the collection.
  static void deleteBook(String path, String id) {
    final relativePath = BookRepository.getRelativePath(path);
    final json = getJsonData();
    if (json[id] != null) {
      final data = CollectionData.fromJson(json[id]!);
      data.pathList.remove(relativePath);
      json[id] = data.toJson();
      jsonFile.writeAsStringSync(jsonEncode(json));
    }
  }

  /// Deletes the book from all collections.
  static void deleteAssociatedBook(String path) {
    final collectionList = getList().where(
        (e) => e.pathList.contains(BookRepository.getRelativePath(path)));
    for (CollectionData data in collectionList) {
      deleteBook(path, data.id);
    }
  }

  /// Reset the collection repository.
  static void reset() {
    jsonFile.writeAsStringSync('{}');
  }
}
