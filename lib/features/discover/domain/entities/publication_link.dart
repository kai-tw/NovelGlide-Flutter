import 'package:equatable/equatable.dart';

import '../../../../core/mime_resolver/domain/entities/mime_type.dart';

enum PublicationLinkRelationship {
  thumbnail,
  cover,
  acquisition,
  buy,
  borrow,
  subscribe,
  sample,
}

/// Represents a link to a related resource, such as a download or cover image.
class PublicationLink extends Equatable {
  const PublicationLink({
    this.href,
    this.rel,
    this.type,
    this.title,
  });

  final Uri? href;
  final PublicationLinkRelationship? rel;
  final MimeType? type;
  final String? title;

  @override
  List<Object?> get props => <Object?>[
        href,
        rel,
        type,
        title,
      ];
}
