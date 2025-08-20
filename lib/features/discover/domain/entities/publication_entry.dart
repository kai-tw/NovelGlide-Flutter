import 'package:equatable/equatable.dart';

import 'publication_author.dart';
import 'publication_link.dart';

/// Represents a single publication or item within a catalog feed.
class PublicationEntry extends Equatable {
  const PublicationEntry({
    required this.id,
    required this.title,
    required this.updated,
    required this.authors,
    required this.links,
    this.summary,
    this.publishedDate,
    this.publisher,
  });

  final String id;
  final String title;
  final DateTime updated;
  final String? summary;
  final DateTime? publishedDate;
  final String? publisher;
  final List<PublicationAuthor> authors;
  final List<PublicationLink> links;

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        updated,
        summary,
        publishedDate,
        publisher,
        authors,
        links,
      ];
}
