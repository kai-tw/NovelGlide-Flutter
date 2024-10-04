import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../toolbox/random_utility.dart';
import '../toolbox/file_path.dart';

class CollectionData {
  final String id;
  final String name;
  List<String> pathList;

  CollectionData(this.id, this.name, this.pathList);

  static Future<String> get jsonPath async => join(await FilePath.dataRoot, 'collection.json');

  static Future<File> get jsonFile async => File(await jsonPath);

  static Future<Map<String, dynamic>> get jsonData async {
    final File dataFile = await jsonFile;
    dataFile.createSync(recursive: true);

    String jsonString = dataFile.readAsStringSync();
    jsonString = jsonString.isEmpty ? '{}' : jsonString;

    return jsonDecode(jsonString);
  }

  /// Create a new empty collection.
  static Future<void> create(String name) async {
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;
    String id = RandomUtility.getRandomString(10);

    while (json.containsKey(id)) {
      // Key collision
      id = RandomUtility.getRandomString(10);
    }

    json[id] = CollectionData(id, name, const <String>[]).toJson();
    dataFile.writeAsStringSync(jsonEncode(json));
  }

  static Future<CollectionData> fromId(String id) async {
    final Map<String, dynamic> json = await jsonData;

    if (json.containsKey(id)) {
      return await CollectionData.fromJson(json[id]!);
    } else {
      return CollectionData(id, id, const <String>[]);
    }
  }

  static Future<CollectionData> fromJson(Map<String, dynamic> json) async {
    final String libraryRoot = await FilePath.libraryRoot;
    return CollectionData(
      json['id'] as String,
      json['name'] as String,
      List<String>.from(json['pathList'] ?? []).map<String>((e) => isAbsolute(e) ? e : join(libraryRoot, e)).toList(),
    );
  }

  static Future<List<CollectionData>> getList() async {
    final Map<String, dynamic> json = await jsonData;
    List<CollectionData> list = [];

    for (var key in json.keys) {
      CollectionData data = await CollectionData.fromJson(json[key]!);
      list.add(data);
    }

    return list;
  }

  static void reorder(int oldIndex, int newIndex) async {
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;
    newIndex = newIndex - (oldIndex < newIndex ? 1 : 0);

    CollectionData data = await CollectionData.fromJson(json[json.keys.elementAt(oldIndex)]!);
    json.remove(json.keys.elementAt(oldIndex));
    json[data.id] = data.toJson();

    int loopTime = json.keys.length - newIndex - 1;
    while (loopTime-- > 0) {
      data = await CollectionData.fromJson(json[json.keys.elementAt(newIndex)]!);
      json.remove(json.keys.elementAt(newIndex));
      json[data.id] = data.toJson();
    }
    dataFile.writeAsStringSync(jsonEncode(json));
  }

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pathList': [
          ...{...pathList}
        ],
      };

  Future<void> save() async {
    final String libraryRoot = await FilePath.libraryRoot;
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;

    // Turn absolute path to relative path.
    pathList = pathList.map<String>((e) => isAbsolute(e) ? relative(e, from: libraryRoot) : e).toList();

    // Save to file.
    json[id] = toJson();
    dataFile.writeAsStringSync(jsonEncode(json));
  }

  Future<void> delete() async {
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;

    json.remove(id);
    dataFile.writeAsStringSync(jsonEncode(json));
  }
}
