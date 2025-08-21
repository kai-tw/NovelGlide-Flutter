import 'package:equatable/equatable.dart';

class DiscoverFavoriteCatalogData extends Equatable {
  const DiscoverFavoriteCatalogData({
    required this.name,
    required this.uri,
  });

  final String name;
  final Uri uri;

  @override
  List<Object?> get props => <Object?>[
        name,
        uri,
      ];
}
