import 'package:equatable/equatable.dart';

class CollectionData extends Equatable {
  const CollectionData({
    required this.id,
    required this.name,
    required this.pathList,
  });

  final String id;
  final String name;
  final List<String> pathList;

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        pathList,
      ];
}
