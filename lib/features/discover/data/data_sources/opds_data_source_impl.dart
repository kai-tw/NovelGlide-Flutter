import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rss_dart/dart_rss.dart';
import 'package:xml/xml.dart';

import '../../../../core/mime_resolver/domain/entities/mime_type.dart';
import '../../domain/entities/catalog_feed.dart';
import '../../domain/entities/publication_author.dart';
import '../../domain/entities/publication_entry.dart';
import '../../domain/entities/publication_link.dart';
import 'discover_data_source.dart';

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
      try {
        final AtomFeed feed = AtomFeed.parse(response.body);

        return CatalogFeed(
          id: feed.id,
          title: feed.title,
          updated: _parseDateTime(feed.updated),
          links: feed.links.map(_parseLink).toList(),
          entries: feed.items.map(_parseEntry).toList(),
        );
      } catch (e, s) {
        throw Exception('Failed to parse the atom feed.');
      }
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
    return value == null ? null : DateTime.parse(value);
  }

  PublicationLink _parseLink(AtomLink link) {
    return PublicationLink(
      href: link.href == null ? null : Uri.tryParse(link.href!),
      rel: link.rel,
      type: link.type == null ? null : MimeType.fromString(link.type!),
    );
  }

  PublicationEntry _parseEntry(AtomItem item) {
    return PublicationEntry(
      id: item.id,
      title: item.title,
      updated: _parseDateTime(item.updated),
      summary: item.content,
      authors: item.authors.map(_parseAuthor).toList(),
      links: item.links.map(_parseLink).toList(),
    );
  }

  PublicationAuthor _parseAuthor(AtomPerson person) {
    return PublicationAuthor(
      name: person.name,
    );
  }
}
