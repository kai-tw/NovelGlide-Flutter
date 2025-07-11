import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../../../core/services/file_path.dart';
import '../../../core/utils/json_utils.dart';
import '../../../core/utils/random_utils.dart';
import '../../book_service/book_service.dart';
import 'collection_data.dart';

class CollectionRepository {
  CollectionRepository._();

  static String jsonFileName = 'collection.json';

  static String get jsonPath => join(FilePath.dataRoot, jsonFileName);

  static File get jsonFile {
    final File file = File(jsonPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  /// JSON data getter
  static Map<String, dynamic> get jsonData => JsonUtils.fromFile(jsonFile);

  /// JSON data setter
  static set jsonData(Map<String, dynamic> json) => jsonFile.writeAsStringSync(jsonEncode(json));

  /// Create a new empty collection with a unique ID.
  static void create(String name) {
    final Map<String, dynamic> data = jsonData;
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
    final List<CollectionData> list = <CollectionData>[];

    for (String key in jsonData.keys) {
      list.add(CollectionData.fromJson(jsonData[key]!));
    }

    return list;
  }

  /// Save the current [CollectionData] instance to the JSON file.
  static void save(CollectionData data) {
    final Map<String, dynamic> json = jsonData;
    data.pathList = data.pathList.toSet().map<String>((String e) => BookService.repository.getRelativePath(e)).toList();
    json[data.id] = data.toJson();
    jsonData = json;
  }

  /// Delete the current [CollectionData] instance from the JSON file.
  static void delete(CollectionData data) {
    final Map<String, dynamic> json = jsonData;
    json.remove(data.id);
    jsonData = json;
  }

  /// Delete the book_service from the collection.
  static void deleteBook(String path, String id) {
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
  static void deleteByPath(String path) {
    final Iterable<CollectionData> collectionList =
        getList().where((CollectionData e) => e.pathList.contains(BookService.repository.getRelativePath(path)));
    for (CollectionData data in collectionList) {
      deleteBook(path, data.id);
    }
  }

  /// Reset the collection repository.
  static void reset() => jsonData = <String, dynamic>{};
}
