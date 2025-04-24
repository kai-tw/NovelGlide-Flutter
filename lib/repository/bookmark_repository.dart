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
    final List<BookmarkData> retList = <BookmarkData>[];

    for (String key in jsonData.keys) {
      final BookmarkData data = BookmarkData.fromJson(jsonData[key]!);
      final String path = BookRepository.getAbsolutePath(data.bookPath);

      if (File(path).existsSync()) {
        retList.add(data);
      } else {
        delete(data);
      }
    }

    return retList;
  }

  /// Save the current bookmark to the JSON file.
  static Future<void> save(BookmarkData data) async {
    final Map<String, dynamic> json = jsonData;
    final BookmarkData savedData = data.copyWith(
      bookPath: BookRepository.getRelativePath(data.bookPath),
      savedTime: DateTime.now(),
    );
    json[savedData.bookPath] = savedData.toJson();
    jsonData = json;
  }

  /// Delete the current bookmark from the JSON file.
  static void delete(BookmarkData data) {
    final Map<String, dynamic> json = jsonData;
    final String path = BookRepository.getRelativePath(data.bookPath);
    json.remove(path);
    jsonData = json;
  }

  /// Delete the bookmark by path.
  static void deleteByPath(String path) {
    getList()
        .where((BookmarkData e) =>
            BookRepository.getRelativePath(e.bookPath) ==
            BookRepository.getRelativePath(path))
        .forEach(delete);
  }

  /// Reset the bookmark repository.
  static void reset() => jsonData = <String, dynamic>{};
}
