import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../utils/file_path.dart';
import '../utils/random_utils.dart';

/// Represents a collection of data with an ID, name, and a list of paths.
class CollectionData {
  final String id;
  final String name;
  List<String> pathList;

  static String jsonFileName = 'collection.json';

  CollectionData(this.id, this.name, this.pathList);

  static String get jsonPath => join(FilePath.dataRoot, jsonFileName);

  static File get jsonFile => File(jsonPath);

  static Map<String, dynamic> get jsonData {
    jsonFile.createSync(recursive: true);

    String jsonString = jsonFile.readAsStringSync();
    jsonString = jsonString.isEmpty ? '{}' : jsonString;

    return jsonDecode(jsonString);
  }

  /// Creates a new empty collection with a unique ID.
  static Future<void> create(String name) async {
    String id = RandomUtils.getRandomString(10);

    while (jsonData.containsKey(id)) {
      id = RandomUtils.getRandomString(10);
    }

    jsonData[id] = CollectionData(id, name, const <String>[]).toJson();
    jsonFile.writeAsStringSync(jsonEncode(json));
  }

  /// Retrieves a [CollectionData] instance by its ID.
  factory CollectionData.fromId(String id) {
    if (jsonData.containsKey(id)) {
      return CollectionData.fromJson(jsonData[id]!);
    } else {
      return CollectionData(id, id, const <String>[]);
    }
  }

  /// Creates a [CollectionData] instance from a JSON map.
  factory CollectionData.fromJson(Map<String, dynamic> json) {
    return CollectionData(
      json['id'] as String,
      json['name'] as String,
      List<String>.from(json['pathList'] ?? [])
          .map<String>((e) => isAbsolute(e) ? e : join(FilePath.libraryRoot, e))
          .toList(),
    );
  }

  /// Retrieves a list of all [CollectionData] instances.
  static Future<List<CollectionData>> getList() async {
    List<CollectionData> list = [];

    for (var key in jsonData.keys) {
      CollectionData data = CollectionData.fromJson(jsonData[key]!);
      list.add(data);
    }

    return list;
  }

  /// Reorders the collection data based on the given indices.
  static Future<void> reorder(int oldIndex, int newIndex) async {
    newIndex = newIndex - (oldIndex < newIndex ? 1 : 0);

    CollectionData data =
        CollectionData.fromJson(jsonData[jsonData.keys.elementAt(oldIndex)]!);
    jsonData.remove(jsonData.keys.elementAt(oldIndex));
    jsonData[data.id] = data.toJson();

    int loopTime = jsonData.keys.length - newIndex - 1;
    while (loopTime-- > 0) {
      data =
          CollectionData.fromJson(jsonData[jsonData.keys.elementAt(newIndex)]!);
      jsonData.remove(jsonData.keys.elementAt(newIndex));
      jsonData[data.id] = data.toJson();
    }
    jsonFile.writeAsStringSync(jsonEncode(json));
  }

  /// Creates a copy of the current [CollectionData] with optional new values.
  CollectionData copyWith({
    String? id,
    String? name,
    List<String>? pathList,
  }) {
    return CollectionData(
      id ?? this.id,
      name ?? this.name,
      pathList ?? this.pathList,
    );
  }

  /// Converts the [CollectionData] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pathList': [
          ...{...pathList}
        ],
      };

  /// Saves the current [CollectionData] instance to the JSON file.
  Future<void> save() async {
    pathList = pathList
        .map<String>(
          (e) => isAbsolute(e) ? relative(e, from: FilePath.libraryRoot) : e,
        )
        .toList();

    jsonData[id] = toJson();
    jsonFile.writeAsStringSync(jsonEncode(jsonData));
  }

  /// Deletes the current [CollectionData] instance from the JSON file.
  Future<void> delete() async {
    jsonData.remove(id);
    jsonFile.writeAsStringSync(jsonEncode(json));
  }
}
