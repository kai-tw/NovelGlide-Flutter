import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rss_dart/dart_rss.dart';
import 'package:xml/xml.dart';

import '../../../../../core/log_system/log_system.dart';
import '../../../../../core/mime_resolver/domain/entities/mime_type.dart';
import '../../../domain/entities/catalog_feed.dart';
import '../../../domain/entities/publication_author.dart';
import '../../../domain/entities/publication_entry.dart';
import '../../../domain/entities/publication_link.dart';
import '../discover_data_source.dart';

/// A concrete implementation of DiscoverDataSource for OPDS feeds.
class OpdsDataSourceImpl implements DiscoverDataSource {
  OpdsDataSourceImpl();

  final http.Client _httpClient = http.Client();

  /// Fetches an OPDS catalog feed from a given URL and parses it.
  @override
  Future<CatalogFeed> getCatalogFeed(String url) async {
    final Uri uri = Uri.parse(url);
    final http.Response response = await _httpClient.get(uri);

    if (response.statusCode == 200) {
      final AtomFeed feed = AtomFeed.parse(response.body);

      return CatalogFeed(
        id: feed.id?.trim(),
        title: feed.title?.trim(),
        updated: _parseDateTime(feed.updated),
        links: feed.links.map(_parseLink).toList(),
        entries: feed.items.map(_parseEntry).toList(),
      );
    } else {
      throw Exception('Failed to load OPDS feed (${response.statusCode})');
    }
  }

  /// Searches an OPDS catalog using a query.
  @override
  Future<CatalogFeed> searchCatalogFeed(String url, String query) async {
    final Uri searchUrl =
        Uri.parse(url).replace(queryParameters: <String, dynamic>{'q': query});
    final http.Response response = await _httpClient.get(searchUrl);

    if (response.statusCode == 200) {
      final XmlDocument document =
          XmlDocument.parse(utf8.decode(response.bodyBytes));
      return CatalogFeed(
        id: '',
        title: '',
        updated: DateTime.now(),
        links: [],
        entries: [],
      );
    } else {
      throw Exception('Failed to search OPDS feed');
    }
  }

  /// ========== Parsers ==========

  DateTime? _parseDateTime(String? value) {
    if (value == null) {
      return null;
    }

    try {
      return DateTime.parse(value);
    } catch (_) {
      // Failed to parse by default. Try some known formats.
    }

    final List<String> formatPattern = <String>[
      'EEE, dd MMM yyyy HH:mm:ss Z',
    ];

    for (final String pattern in formatPattern) {
      try {
        return DateFormat(pattern).parse(value);
      } catch (_) {}
    }

    LogSystem.error('Failed to parse date time: $value');
    return null;
  }

  PublicationLink _parseLink(AtomLink link) {
    final Uri? href = link.href == null ? null : Uri.tryParse(link.href!);
    final String? rel = link.rel?.trim();
    final MimeType? mimeType =
        link.type == null ? null : MimeType.fromString(link.type!);
    return PublicationLink(
      href: href,
      rel: switch (rel) {
        'http://opds-spec.org/thumbnail' =>
          PublicationLinkRelationship.thumbnail,
        'http://opds-spec.org/cover' => PublicationLinkRelationship.cover,
        _ => null,
      },
      type: mimeType,
    );
  }

  PublicationEntry _parseEntry(AtomItem item) {
    return PublicationEntry(
      id: item.id?.trim(),
      title: item.title?.trim(),
      updated: _parseDateTime(item.updated),
      summary: item.summary,
      content: item.content?.trim(),
      authors: item.authors.map(_parseAuthor).toList(),
      links: item.links.map(_parseLink).toList(),
    );
  }

  PublicationAuthor _parseAuthor(AtomPerson person) {
    return PublicationAuthor(
      name: person.name?.trim(),
    );
  }
}
