import 'dart:convert';
import 'dart:io';

import '../data_model/bookmark_data.dart';
import '../utils/json_utils.dart';
import 'book_repository.dart';
import 'repository_interface.dart';

class BookmarkRepository {
  BookmarkRepository._();

  static String jsonFileName = 'bookmark.json';

  /// Returns the path to the JSON file storing bookmarks.
  static String get jsonPath => RepositoryInterface.getJsonPath(jsonFileName);

  /// Returns the File object for the JSON file storing bookmarks.
  static File get jsonFile => RepositoryInterface.getJsonFile(jsonPath);

  /// Reads and returns the JSON data from the bookmark file.
  static Map<String, dynamic> get jsonData => JsonUtils.fromFile(jsonFile);

  /// Retrieves a bookmark by its book path.
  static BookmarkData? get(String bookPath) {
    bookPath = BookRepository.getRelativePath(bookPath);
    return jsonData.containsKey(bookPath)
        ? BookmarkData.fromJson(jsonData[bookPath]!)
        : null;
  }

  /// Retrieves a list of all bookmarks.
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

  /// Saves the current bookmark to the JSON file.
  static void save(BookmarkData data) async {
    final json = jsonData;
    data.bookPath = BookRepository.getRelativePath(data.bookPath);
    json[data.bookPath] = data.toJson();
    jsonFile.writeAsStringSync(jsonEncode(json));
  }

  /// Deletes the current bookmark from the JSON file.
  static void delete(BookmarkData data) {
    final json = jsonData;
    final path = BookRepository.getRelativePath(data.bookPath);
    json.remove(path);
    jsonFile.writeAsStringSync(jsonEncode(json));
  }

  /// Deletes the bookmark that is associated with the book.
  static void deleteAssociatedBook(String path) {
    final bookmarkList = getList().where((e) =>
        BookRepository.getRelativePath(e.bookPath) ==
        BookRepository.getRelativePath(path));
    for (final data in bookmarkList) {
      delete(data);
    }
  }

  /// Reset the bookmark repository.
  static void reset() {
    jsonFile.writeAsStringSync('{}');
  }
}
