import 'package:equatable/equatable.dart';

import 'publication_entry.dart';
import 'publication_link.dart';

/// Represents a catalog feed, which is a collection of publication entries.
class CatalogFeed extends Equatable {
  const CatalogFeed({
    this.id,
    this.title,
    this.updated,
    this.links = const <PublicationLink>[],
    this.entries = const <PublicationEntry>[],
  });

  final String? id;
  final String? title;
  final DateTime? updated;
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
