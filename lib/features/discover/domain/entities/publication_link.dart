import 'package:equatable/equatable.dart';

/// Represents a link to a related resource, such as a download or cover image.
class PublicationLink extends Equatable {
  const PublicationLink({
    required this.href,
    required this.rel,
    required this.type,
    this.title,
  });

  final String href;
  final String rel;
  final String type;
  final String? title;

  @override
  List<Object?> get props => <Object?>[href, rel, type, title];
}
