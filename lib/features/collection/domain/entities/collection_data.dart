import 'package:equatable/equatable.dart';

class CollectionData extends Equatable {
  const CollectionData({
    required this.id,
    required this.name,
    required this.pathList,
  });

  factory CollectionData.fromJson(Map<String, dynamic> json) {
    return CollectionData(
      id: json['id'] as String,
      name: json['name'] as String,
      pathList: List<String>.from(json['pathList'] ?? <String>[]),
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
      id: id ?? this.id,
      name: name ?? this.name,
      pathList: pathList ?? this.pathList,
    );
  }
}
