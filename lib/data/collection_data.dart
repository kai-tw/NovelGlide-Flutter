import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';

import '../toolbox/random_utility.dart';
import 'file_path.dart';

class CollectionData {
  static const String hiveBoxName = 'collection';

  final String id;
  final String name;
  final Color? color;
  List<String> pathList;

  CollectionData(this.id, this.name, this.color, this.pathList);

  factory CollectionData.fromName(String name) {
    final Box<Map<String, dynamic>?> box = Hive.box(name: hiveBoxName);
    String id = RandomUtility.getRandomString(10);

    while (box.containsKey(id)) {
      // Key collision
      id = RandomUtility.getRandomString(10);
    }

    box.close();

    return CollectionData(id, name, null, const <String>[]);
  }

  static Future<CollectionData> fromJson(Map<String, dynamic> json) async {
    final String libraryRoot = await FilePath.libraryRoot;
    return CollectionData(
      json['id'] as String,
      json['name'] as String,
      json['color'] != null ? Color(json['color'] as int) : null,
      List<String>.from(json['pathList'] ?? []).map<String>((e) => isAbsolute(e) ? e : join(libraryRoot, e)).toList(),
    );
  }

  static Future<List<CollectionData>> getList() async {
    final Box<Map<String, dynamic>> box = Hive.box(name: hiveBoxName);
    List<CollectionData> list = [];

    for (var key in box.keys) {
      CollectionData data = await CollectionData.fromJson(box.get(key)!);
      list.add(data);
    }

    box.close();

    return list;
  }

  static void reorder(int oldIndex, int newIndex) async {
    final Box<Map<String, dynamic>> box = Hive.box(name: hiveBoxName);
    newIndex = newIndex - (oldIndex < newIndex ? 1 : 0);

    CollectionData data = await CollectionData.fromJson(box.getAt(oldIndex));
    box.deleteAt(oldIndex);
    box.put(data.id, data.toJson());

    int loopTime = box.length - newIndex - 1;
    while (loopTime-- > 0) {
      data = await CollectionData.fromJson(box.getAt(newIndex));
      box.deleteAt(newIndex);
      box.put(data.id, data.toJson());
    }
    box.close();
  }

  CollectionData copyWith({
    String? id,
    String? name,
    Color? color,
    List<String>? pathList,
  }) {
    return CollectionData(
      id ?? this.id,
      name ?? this.name,
      color ?? this.color,
      pathList ?? this.pathList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color': color?.value,
        'pathList': [
          ...{...pathList}
        ],
      };

  void save() async {
    final String libraryRoot = await FilePath.libraryRoot;
    final Box<Map<String, dynamic>?> box = Hive.box(name: hiveBoxName);
    pathList = pathList.map<String>((e) => isAbsolute(e) ? relative(e, from: libraryRoot) : e).toList();
    box.put(id, toJson());
    box.close();
  }

  void delete() {
    final Box<Map<String, dynamic>?> box = Hive.box(name: hiveBoxName);
    box.delete(id);
    box.close();
  }
}
