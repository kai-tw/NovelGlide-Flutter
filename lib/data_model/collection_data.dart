import 'dart:convert';

import '../utils/file_path.dart';
import '../utils/file_utils.dart';

/// Represents a collection of data with an ID, name, and a list of paths.
class CollectionData {
  final String id;
  final String name;
  List<String> pathList;

  CollectionData(this.id, this.name, this.pathList);

  /// Creates a [CollectionData] instance from a JSON map.
  factory CollectionData.fromJson(Map<String, dynamic> json) {
    return CollectionData(
      json['id'] as String,
      json['name'] as String,
      List<String>.from(json['pathList'] ?? [])
          .map<String>(
              (e) => FileUtils.getAbsolutePath(e, FilePath.libraryRoot))
          .toList(),
    );
  }

  /// Converts the [CollectionData] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pathList': pathList
            .map<String>(
                (e) => FileUtils.getRelativePath(e, FilePath.libraryRoot))
            .toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionData &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => jsonEncode(toJson());
}
