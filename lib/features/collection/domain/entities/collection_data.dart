import 'package:equatable/equatable.dart';

class CollectionData extends Equatable {
  const CollectionData(
    this.id,
    this.name,
    this.pathList,
  );

  factory CollectionData.fromJson(Map<String, dynamic> json) {
    return CollectionData(
      json['id'] as String,
      json['name'] as String,
      List<String>.from(json['pathList'] ?? <String>[]),
    );
  }

  final String id;
  final String name;
  final List<String> pathList;

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        pathList,
      ];

  /// Converts the [CollectionData] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'pathList': pathList,
    };
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
}
