import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../data_model/bookmark_data.dart';
import '../utils/file_path.dart';
import '../utils/json_utils.dart';

class BookmarkRepository {
  BookmarkRepository._();

  static String jsonFileName = 'bookmark.json';

  /// Returns the path to the JSON file storing bookmarks.
  static String get jsonPath => join(FilePath.dataRoot, jsonFileName);

  /// Returns the File object for the JSON file storing bookmarks.
  static File get jsonFile {
    final file = File(jsonPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  /// Reads and returns the JSON data from the bookmark file.
  static Map<String, dynamic> get jsonData => JsonUtils.fromFile(jsonFile);

  /// Retrieves a bookmark by its book path.
  static BookmarkData? get(String bookPath) {
    bookPath = relative(bookPath, from: FilePath.libraryRoot);
    return jsonData.containsKey(bookPath)
        ? BookmarkData.fromJson(jsonData[bookPath]!)
        : null;
  }

  /// Retrieves a list of all bookmarks.
  static List<BookmarkData> getList() {
    List<BookmarkData> retList = [];

    for (String key in jsonData.keys) {
      final data = BookmarkData.fromJson(jsonData[key]!);
      final path = absolute(FilePath.libraryRoot, data.bookPath);

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
    final path = relative(data.bookPath, from: FilePath.libraryRoot);
    json[path] = data.toJson();
    jsonFile.writeAsStringSync(jsonEncode(json));
  }

  /// Deletes the current bookmark from the JSON file.
  static void delete(BookmarkData data) {
    final json = jsonData;
    final path = relative(data.bookPath, from: FilePath.libraryRoot);
    json.remove(path);
    jsonFile.writeAsStringSync(jsonEncode(json));
  }
}
