import 'package:equatable/equatable.dart';

class ExploreAddFavoritePageState extends Equatable {
  const ExploreAddFavoritePageState({
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

  ExploreAddFavoritePageState copyWithName(String? name) {
    return ExploreAddFavoritePageState(
      name: name,
      uri: uri,
    );
  }

  ExploreAddFavoritePageState copyWithUrl(Uri? uri) {
    return ExploreAddFavoritePageState(
      name: name,
      uri: uri,
    );
  }
}
