import 'package:equatable/equatable.dart';

class DiscoverAddFavoritePageState extends Equatable {
  const DiscoverAddFavoritePageState({
    this.name,
    this.uri,
  });

  final String? name;
  final Uri? uri;

  bool get isValid => name != null && uri != null;

  @override
  List<Object?> get props => <Object?>[
        name,
        uri,
      ];

  DiscoverAddFavoritePageState copyWithName(String? name) {
    return DiscoverAddFavoritePageState(
      name: name,
      uri: uri,
    );
  }

  DiscoverAddFavoritePageState copyWithUrl(Uri? uri) {
    return DiscoverAddFavoritePageState(
      name: name,
      uri: uri,
    );
  }
}
