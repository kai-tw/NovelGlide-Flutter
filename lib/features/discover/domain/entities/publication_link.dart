import 'package:equatable/equatable.dart';

import '../../../../core/mime_resolver/domain/entities/mime_type.dart';

/// Represents a link to a related resource, such as a download or cover image.
class PublicationLink extends Equatable {
  const PublicationLink({
    this.href,
    this.rel,
    this.type,
    this.title,
  });

  final Uri? href;
  final String? rel;
  final MimeType? type;
  final String? title;

  @override
  List<Object?> get props => <Object?>[href, rel, type, title];
}
