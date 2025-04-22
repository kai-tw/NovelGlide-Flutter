import 'dart:convert';
import 'dart:io';

import '../data_model/bookmark_data.dart';
import '../utils/json_utils.dart';
import 'book_repository.dart';
import 'repository_interface.dart';

class BookmarkRepository {
  BookmarkRepository._();

  static String jsonFileName = 'bookmark.json';

  static String get jsonPath => RepositoryInterface.getJsonPath(jsonFileName);

  static File get jsonFile => RepositoryInterface.getJsonFile(jsonPath);

  /// JSON data getter
  static Map<String, dynamic> get jsonData => JsonUtils.fromFile(jsonFile);

  /// JSON data setter
  static set jsonData(Map<String, dynamic> json) =>
      jsonFile.writeAsStringSync(jsonEncode(json));

  /// Retrieve a bookmark by its book path.
  static BookmarkData? get(String bookPath) {
    bookPath = BookRepository.getRelativePath(bookPath);
    return jsonData.containsKey(bookPath)
        ? BookmarkData.fromJson(jsonData[bookPath]!)
        : null;
  }

  /// Retrieve a list of all bookmarks.
  static List<BookmarkData> getList() {
    List<BookmarkData> retList = [];

    for (String key in jsonData.keys) {
      final data = BookmarkData.fromJson(jsonData[key]!);
      final path = BookRepository.getAbsolutePath(data.bookPath);

      if (File(path).existsSync()) {
        retList.add(data);
      } else {
        delete(data);
      }
    }

    return retList;
  }

  /// Save the current bookmark to the JSON file.
  static void save(BookmarkData data) async {
    final json = jsonData;
    final savedData = data.copyWith(
      bookPath: BookRepository.getAbsolutePath(data.bookPath),
      savedTime: DateTime.now(),
    );
    json[savedData.bookPath] = savedData.toJson();
    jsonData = json;
  }

  /// Delete the current bookmark from the JSON file.
  static void delete(BookmarkData data) {
    final json = jsonData;
    final path = BookRepository.getRelativePath(data.bookPath);
    json.remove(path);
    jsonData = json;
  }

  /// Delete the bookmark by path.
  static void deleteByPath(String path) {
    final bookmarkList = getList().where((e) =>
        BookRepository.getRelativePath(e.bookPath) ==
        BookRepository.getRelativePath(path));
    for (final data in bookmarkList) {
      delete(data);
    }
  }

  /// Reset the bookmark repository.
  static void reset() => jsonData = {};
}
