import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../toolbox/random_utility.dart';

class CategoryData extends Equatable {
  static const String hiveBoxName = 'category';

  final String id;
  final String name;
  final Color? color;
  final Set<String> pathSet;

  @override
  List<Object?> get props => [id, name, color, pathSet];

  const CategoryData(this.id, this.name, this.color, this.pathSet);

  factory CategoryData.fromName(String name) {
    final Box box = Hive.box(name: hiveBoxName);
    String id = RandomUtility.getRandomString(10);

    while (box.containsKey(id)) {
      // Key collision
      id = RandomUtility.getRandomString(10);
    }

    box.close();

    return CategoryData(id, name, null, const <String>{});
  }

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      json['id'] as String,
      json['name'] as String,
      json['color'] != null ? Color(json['color'] as int) : null,
      Set<String>.from(json['pathSet'] as List<dynamic>),
    );
  }

  static List<CategoryData> getList() {
    final Box box = Hive.box(name: hiveBoxName);
    List<CategoryData> list = [];

    for (var key in box.keys) {
      CategoryData data = CategoryData.fromJson(box.get(key));
      for (var path in data.pathSet) {
        if (!File(path).existsSync()) {
          data.pathSet.remove(path);
        }
      }
      list.add(data);
    }

    box.close();

    return list;
  }

  CategoryData copyWith({
    String? id,
    String? name,
    Color? color,
    Set<String>? pathSet,
  }) {
    return CategoryData(
      id ?? this.id,
      name ?? this.name,
      color ?? this.color,
      pathSet ?? this.pathSet,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color': color?.value,
        'pathSet': pathSet.toList(),
      };

  void save() {
    final Box box = Hive.box(name: hiveBoxName);
    box.put(id, toJson());
    box.close();
  }

  void delete() {
    final Box box = Hive.box(name: hiveBoxName);
    box.delete(id);
    box.close();
  }
}
