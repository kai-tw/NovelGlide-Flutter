import 'package:equatable/equatable.dart';

class ExploreFavoriteCatalogData extends Equatable {
  const ExploreFavoriteCatalogData({
    required this.identifier,
    required this.name,
    required this.uri,
  });

  final String identifier;
  final String name;
  final Uri uri;

  @override
  List<Object?> get props => <Object?>[
        identifier,
        name,
        uri,
      ];
}
