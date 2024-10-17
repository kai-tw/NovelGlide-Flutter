import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../toolbox/file_path.dart';
import '../toolbox/random_utility.dart';

/// Represents a collection of data with an ID, name, and a list of paths.
class CollectionData {
  final String id;
  final String name;
  List<String> pathList;

  static String jsonFileName = 'collection.json';

  CollectionData(this.id, this.name, this.pathList);

  static Future<String> get jsonPath async =>
      join(await FilePath.dataRoot, jsonFileName);

  static Future<File> get jsonFile async => File(await jsonPath);

  static Future<Map<String, dynamic>> get jsonData async {
    final File dataFile = await jsonFile;
    dataFile.createSync(recursive: true);

    String jsonString = dataFile.readAsStringSync();
    jsonString = jsonString.isEmpty ? '{}' : jsonString;

    return jsonDecode(jsonString);
  }

  /// Creates a new empty collection with a unique ID.
  static Future<void> create(String name) async {
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;
    String id = RandomUtility.getRandomString(10);

    while (json.containsKey(id)) {
      id = RandomUtility.getRandomString(10);
    }

    json[id] = CollectionData(id, name, const <String>[]).toJson();
    dataFile.writeAsStringSync(jsonEncode(json));
  }

  /// Retrieves a [CollectionData] instance by its ID.
  static Future<CollectionData> fromId(String id) async {
    final Map<String, dynamic> json = await jsonData;

    if (json.containsKey(id)) {
      return await CollectionData.fromJson(json[id]!);
    } else {
      return CollectionData(id, id, const <String>[]);
    }
  }

  /// Creates a [CollectionData] instance from a JSON map.
  static Future<CollectionData> fromJson(Map<String, dynamic> json) async {
    final String libraryRoot = await FilePath.libraryRoot;
    return CollectionData(
      json['id'] as String,
      json['name'] as String,
      List<String>.from(json['pathList'] ?? [])
          .map<String>((e) => isAbsolute(e) ? e : join(libraryRoot, e))
          .toList(),
    );
  }

  /// Retrieves a list of all [CollectionData] instances.
  static Future<List<CollectionData>> getList() async {
    final Map<String, dynamic> json = await jsonData;
    List<CollectionData> list = [];

    for (var key in json.keys) {
      CollectionData data = await CollectionData.fromJson(json[key]!);
      list.add(data);
    }

    return list;
  }

  /// Reorders the collection data based on the given indices.
  static Future<void> reorder(int oldIndex, int newIndex) async {
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;
    newIndex = newIndex - (oldIndex < newIndex ? 1 : 0);

    CollectionData data =
        await CollectionData.fromJson(json[json.keys.elementAt(oldIndex)]!);
    json.remove(json.keys.elementAt(oldIndex));
    json[data.id] = data.toJson();

    int loopTime = json.keys.length - newIndex - 1;
    while (loopTime-- > 0) {
      data =
          await CollectionData.fromJson(json[json.keys.elementAt(newIndex)]!);
      json.remove(json.keys.elementAt(newIndex));
      json[data.id] = data.toJson();
    }
    dataFile.writeAsStringSync(jsonEncode(json));
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
    final String libraryRoot = await FilePath.libraryRoot;
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;

    pathList = pathList
        .map<String>((e) => isAbsolute(e) ? relative(e, from: libraryRoot) : e)
        .toList();

    json[id] = toJson();
    dataFile.writeAsStringSync(jsonEncode(json));
  }

  /// Deletes the current [CollectionData] instance from the JSON file.
  Future<void> delete() async {
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;

    json.remove(id);
    dataFile.writeAsStringSync(jsonEncode(json));
  }
}
