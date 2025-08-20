import '../../domain/entities/publication_author.dart';
import '../../domain/entities/publication_entry.dart';
import '../../domain/entities/publication_link.dart';

/// A data model for a PublicationEntry.
class PublicationEntryModel {
  const PublicationEntryModel({
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
  final String updated;
  final String? summary;
  final String? publishedDate;
  final String? publisher;
  final List<Map<String, String?>> authors;
  final List<Map<String, String?>> links;

  PublicationEntry toEntity() {
    return PublicationEntry(
      id: id,
      title: title,
      updated: DateTime.parse(updated),
      summary: summary,
      publishedDate:
          publishedDate != null ? DateTime.tryParse(publishedDate!) : null,
      publisher: publisher,
      authors: authors
          .map((Map<String, String?> author) => PublicationAuthor(
                name: author['name'] ?? '',
              ))
          .toList(),
      links: links
          .map((Map<String, String?> link) => PublicationLink(
                href: link['href'] ?? '',
                rel: link['rel'] ?? '',
                type: link['type'] ?? '',
                title: link['title'],
              ))
          .toList(),
    );
  }
}
