import 'package:equatable/equatable.dart';

/// Represents a publication's author or contributor.
class PublicationAuthor extends Equatable {
  const PublicationAuthor({
    this.name,
    this.uri,
  });

  final String? name;
  final Uri? uri;

  @override
  List<Object?> get props => <Object?>[
        name,
        uri,
      ];
}
