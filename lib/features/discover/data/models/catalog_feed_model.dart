import '../../domain/entities/catalog_feed.dart';
import '../../domain/entities/publication_link.dart';
import 'publication_entry_model.dart';

/// A data model for a CatalogFeed.
class CatalogFeedModel {
  const CatalogFeedModel({
    required this.id,
    required this.title,
    required this.updated,
    required this.links,
    required this.entries,
  });

  final String id;
  final String title;
  final String updated;
  final List<Map<String, String?>> links;
  final List<PublicationEntryModel> entries;

  CatalogFeed toEntity() {
    return CatalogFeed(
      id: id,
      title: title,
      updated: DateTime.parse(updated),
      links: links
          .map((Map<String, String?> link) => PublicationLink(
                href: link['href'] ?? '',
                rel: link['rel'] ?? '',
                type: link['type'] ?? '',
                title: link['title'],
              ))
          .toList(),
      entries: entries
          .map((PublicationEntryModel entry) => entry.toEntity())
          .toList(),
    );
  }
}
