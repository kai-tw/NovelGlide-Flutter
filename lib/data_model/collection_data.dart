import 'dart:convert';

/// Represents a collection of data with an ID, name, and a list of paths.
class CollectionData {
  CollectionData(this.id, this.name, this.pathList);

  /// Creates a [CollectionData] instance from a JSON map.
  factory CollectionData.fromJson(Map<String, dynamic> json) {
    return CollectionData(
      json['id'] as String,
      json['name'] as String,
      List<String>.from(json['pathList'] ?? <String>[]),
    );
  }

  final String id;
  final String name;
  List<String> pathList;

  /// Converts the [CollectionData] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'pathList': pathList,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id &&
          pathList == other.pathList;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => jsonEncode(toJson());
}
