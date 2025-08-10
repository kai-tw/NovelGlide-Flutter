import 'dart:async';

import '../../../../core/file_system/domain/repositories/json_repository.dart';
import '../../../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../domain/entities/bookmark_data.dart';
import 'bookmark_local_json_data_source.dart';

class BookmarkLocalJsonDataSourceImpl extends BookmarkLocalJsonDataSource {
  BookmarkLocalJsonDataSourceImpl(this._jsonPathProvider, this._jsonRepository);

  final JsonPathProvider _jsonPathProvider;
  final JsonRepository _jsonRepository;

  @override
  Future<void> deleteData(Set<BookmarkData> dataSet) async {
    // Load the data
    final Map<String, dynamic> json = await _loadData();

    // Process the data set
    for (BookmarkData data in dataSet) {
      // Get the identifier of the book
      final String identifier = data.bookIdentifier;

      if (json.containsKey(identifier)) {
        json.remove(identifier);
      }
    }

    // Save to file
    await _writeData(json);
  }

  @override
  Future<BookmarkData?> getDataById(String identifier) async {
    // Load the data
    final Map<String, dynamic> json = await _loadData();

    if (json.containsKey(identifier)) {
      return BookmarkData(
        bookIdentifier: identifier,
        bookName: json[identifier]['bookName'],
        chapterTitle: json[identifier]['chapterTitle'],
        chapterIdentifier: json[identifier]['chapterFileName'],
        startCfi: json[identifier]['startCfi'],
        savedTime: DateTime.parse(json[identifier]['savedTime']),
      );
    }

    return null;
  }

  @override
  Future<List<BookmarkData>> getList() async {
    // Load the data
    final Map<String, dynamic> json = await _loadData();

    // Create the list
    final List<BookmarkData> retList = <BookmarkData>[];

    // Loop through the data
    for (Map<String, dynamic> value in json.values) {
      retList.add(BookmarkData(
        // value['bookPath']: Compatibility for old data.
        bookIdentifier: value['bookIdentifier'] ?? value['bookPath'],
        bookName: value['bookName'],
        chapterTitle: value['chapterTitle'],
        // value['chapterFileName']: Compatibility for old data.
        chapterIdentifier:
            value['chapterIdentifier'] ?? value['chapterFileName'],
        startCfi: value['startCfi'],
        savedTime: DateTime.parse(value['savedTime']),
      ));
    }

    return retList;
  }

  @override
  Future<void> reset() {
    return _writeData(<String, dynamic>{});
  }

  @override
  Future<void> updateData(Set<BookmarkData> dataSet) async {
    // Load the data
    final Map<String, dynamic> json = await _loadData();

    // Process the data set
    for (BookmarkData data in dataSet) {
      // Get the identifier of the book
      final String identifier = data.bookIdentifier;

      json[identifier] = <String, dynamic>{
        'bookPath': data.bookIdentifier,
        'bookName': data.bookName,
        'chapterTitle': data.chapterTitle,
        'chapterIdentifier': data.chapterIdentifier,
        'startCfi': data.startCfi,
        'savedTime': data.savedTime.toIso8601String(),
      };
    }
  }

  /// ========== Utilities ==========

  /// Load json data
  Future<Map<String, dynamic>> _loadData() async {
    final String jsonPath = await _jsonPathProvider.bookmarkJsonPath;
    return _jsonRepository.readJson(path: jsonPath);
  }

  /// Write to file
  Future<void> _writeData(Map<String, dynamic> json) async {
    final String jsonPath = await _jsonPathProvider.bookmarkJsonPath;
    await _jsonRepository.writeJson(path: jsonPath, data: json);
  }
}
