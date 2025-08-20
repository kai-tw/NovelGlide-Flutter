import 'package:equatable/equatable.dart';

import 'publication_entry.dart';
import 'publication_link.dart';

/// Represents a catalog feed, which is a collection of publication entries.
class CatalogFeed extends Equatable {
  const CatalogFeed({
    required this.id,
    required this.title,
    required this.updated,
    required this.links,
    required this.entries,
  });

  final String id;
  final String title;
  final DateTime updated;
  final List<PublicationLink> links;
  final List<PublicationEntry> entries;

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        updated,
        links,
        entries,
      ];
}
