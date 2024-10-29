import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../utils/file_path.dart';
import '../utils/json_utils.dart';
import '../utils/random_utils.dart';
import 'collection_data.dart';

class CollectionRepository {
  static String jsonFileName = 'collection.json';

  static String get jsonPath => join(FilePath.dataRoot, jsonFileName);

  static File get jsonFile {
    final file = File(jsonPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  static Map<String, dynamic> get jsonData => JsonUtils.fromFile(jsonFile);

  /// Creates a new empty collection with a unique ID.
  static void create(String name) {
    final data = jsonData;
    String id = RandomUtils.getRandomString(10);

    while (jsonData.containsKey(id)) {
      id = RandomUtils.getRandomString(10);
    }

    data[id] = CollectionData(id, name, const <String>[]).toJson();
    jsonFile.writeAsStringSync(jsonEncode(data));
  }

  /// Retrieves a list of all [CollectionData] instances.
  static List<CollectionData> getList() {
    List<CollectionData> list = [];

    for (var key in jsonData.keys) {
      list.add(CollectionData.fromJson(jsonData[key]!));
    }

    return list;
  }

  /// Reorders the collection data based on the given indices.
  static void reorder(int oldIndex, int newIndex) {
    newIndex = newIndex - (oldIndex < newIndex ? 1 : 0);

    final oldKey = jsonData.keys.elementAt(oldIndex);
    jsonData[oldKey] = jsonData.remove(oldKey);

    int loopTime = jsonData.keys.length - newIndex - 1;
    while (loopTime-- > 0) {
      // Remove and add the element to move it to last.
      final key = jsonData.keys.elementAt(newIndex);
      jsonData[key] = jsonData.remove(key);
    }
    jsonFile.writeAsStringSync(jsonEncode(json));
  }

  /// Saves the current [CollectionData] instance to the JSON file.
  static void save(CollectionData data) {
    final json = jsonData;
    json[data.id] = data.toJson();
    jsonFile.writeAsStringSync(jsonEncode(json));
  }

  /// Deletes the current [CollectionData] instance from the JSON file.
  static void delete(CollectionData data) {
    final json = jsonData;
    json.remove(data.id);
    jsonFile.writeAsStringSync(jsonEncode(json));
  }
}
