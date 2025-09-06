import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rss_dart/dart_rss.dart';

import '../../../../../core/mime_resolver/domain/entities/mime_type.dart';
import '../../../../../core/parser_system/domain/repository/datetime_parser.dart';
import '../../../../../core/parser_system/domain/repository/uri_parser.dart';
import '../../../domain/entities/catalog_feed.dart';
import '../../../domain/entities/publication_author.dart';
import '../../../domain/entities/publication_entry.dart';
import '../../../domain/entities/publication_link.dart';
import '../discover_data_source.dart';

/// A concrete implementation of DiscoverDataSource for OPDS feeds.
class OpdsDataSourceImpl implements DiscoverDataSource {
  OpdsDataSourceImpl(
    this._dateTimeParser,
    this._uriParser,
  );

  final Dio _dio = Dio();
  final DateTimeParser _dateTimeParser;
  final UriParser _uriParser;

  /// Fetches an OPDS catalog feed from a given URL and parses it.
  @override
  Future<CatalogFeed> getCatalogFeed(Uri uri) async {
    final Response<String> response = await _dio.get(uri.toString());

    if (response.statusCode == 200 && response.data?.isNotEmpty == true) {
      final AtomFeed feed = AtomFeed.parse(response.data!);

      return CatalogFeed(
        id: feed.id?.trim(),
        title: feed.title?.trim(),
        updated: _dateTimeParser.tryParse(feed.updated),
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
    throw UnimplementedError();
  }

  /// ========== Parsers ==========

  PublicationLink _parseLink(AtomLink link) {
    final Uri? href = link.href == null ? null : Uri.tryParse(link.href!);
    final String? rel = link.rel?.trim();
    final List<String>? typeList = link.type?.split(';');
    final String? mimeString = typeList?.first.trim();
    final MimeType? mimeType =
        mimeString == null ? null : MimeType.fromString(mimeString);
    return PublicationLink(
      href: href,
      rel: switch (rel) {
        'http://opds-spec.org/thumbnail' =>
          PublicationLinkRelationship.thumbnail,
        'http://opds-spec.org/cover' => PublicationLinkRelationship.cover,
        _ => null,
      },
      type: mimeType,
      title: link.title,
    );
  }

  PublicationEntry _parseEntry(AtomItem item) {
    return PublicationEntry(
      id: item.id?.trim(),
      title: item.title?.trim(),
      updated: _dateTimeParser.tryParse(item.updated),
      summary: item.summary,
      content: item.content?.trim(),
      authors: item.authors.map(_parseAuthor).toList(),
      links: item.links.map(_parseLink).toList(),
    );
  }

  PublicationAuthor _parseAuthor(AtomPerson person) {
    return PublicationAuthor(
      name: person.name?.trim().isNotEmpty == true ? person.name?.trim() : null,
      uri: person.uri?.trim().isNotEmpty == true
          ? _uriParser.parseHttps(person.uri!)
          : null,
    );
  }
}
