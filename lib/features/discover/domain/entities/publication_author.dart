import 'package:equatable/equatable.dart';

/// Represents a publication's author or contributor.
class PublicationAuthor extends Equatable {
  const PublicationAuthor({
    this.name,
  });

  final String? name;

  @override
  List<Object?> get props => <Object?>[name];
}
