import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import '../models/catalog_feed_model.dart';
import '../models/publication_entry_model.dart';
import 'discover_data_source.dart';

/// A concrete implementation of DiscoverDataSource for OPDS feeds.
class OpdsDataSourceImpl implements DiscoverDataSource {
  OpdsDataSourceImpl();

  final http.Client _httpClient = http.Client();

  /// Fetches an OPDS catalog feed from a given URL and parses it.
  @override
  Future<CatalogFeedModel> getCatalogFeed(String url) async {
    final http.Response response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final XmlDocument document =
          XmlDocument.parse(utf8.decode(response.bodyBytes));
      return _parseFeed(document);
    } else {
      throw Exception('Failed to load OPDS feed');
    }
  }

  /// Searches an OPDS catalog using a query.
  @override
  Future<CatalogFeedModel> searchCatalogFeed(String url, String query) async {
    final Uri searchUrl =
        Uri.parse(url).replace(queryParameters: <String, dynamic>{'q': query});
    final http.Response response = await _httpClient.get(searchUrl);

    if (response.statusCode == 200) {
      final XmlDocument document =
          XmlDocument.parse(utf8.decode(response.bodyBytes));
      return _parseFeed(document);
    } else {
      throw Exception('Failed to search OPDS feed');
    }
  }

  /// Parses the XML document into a CatalogFeedModel.
  CatalogFeedModel _parseFeed(XmlDocument document) {
    final XmlElement root = document.rootElement;
    final List<PublicationEntryModel> entries =
        root.findAllElements('entry').map(_parseEntry).toList();
    final List<Map<String, String?>> links =
        root.findAllElements('link').map(_parseLink).toList();

    return CatalogFeedModel(
      id: root.findElements('id').first.innerText,
      title: root.findElements('title').first.innerText,
      updated: root.findElements('updated').first.innerText,
      links: links,
      entries: entries,
    );
  }

  /// Parses a single XML entry element into a PublicationEntryModel.
  PublicationEntryModel _parseEntry(XmlElement element) {
    final List<Map<String, String>> authors = element
        .findAllElements('author')
        .map((XmlElement e) =>
            <String, String>{'name': e.findElements('name').first.innerText})
        .toList();
    final List<Map<String, String?>> links =
        element.findAllElements('link').map(_parseLink).toList();

    return PublicationEntryModel(
      id: element.findElements('id').first.innerText,
      title: element.findElements('title').first.innerText,
      updated: element.findElements('updated').first.innerText,
      summary: element.findAllElements('summary').firstOrNull?.innerText,
      publishedDate:
          element.findAllElements('published').firstOrNull?.innerText,
      publisher: element.findAllElements('publisher').firstOrNull?.innerText,
      authors: authors,
      links: links,
    );
  }

  /// Parses a single XML link element into a map.
  Map<String, String?> _parseLink(XmlElement element) {
    return <String, String?>{
      'href': element.getAttribute('href'),
      'rel': element.getAttribute('rel'),
      'type': element.getAttribute('type'),
      'title': element.getAttribute('title'),
    };
  }
}
