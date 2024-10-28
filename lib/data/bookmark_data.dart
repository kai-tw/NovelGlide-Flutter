import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../utils/datetime_utils.dart';
import '../utils/file_path.dart';
import '../utils/file_utils.dart';

/// Represents a bookmark with its metadata and operations.
class BookmarkData {
  String bookPath;
  final String bookName;
  final String chapterTitle;
  final String chapterFileName;
  final String? startCfi;
  final DateTime savedTime;

  /// Calculates the number of days passed since the bookmark was saved.
  int get daysPassed => DateTimeUtils.daysPassed(savedTime);

  // Static methods
  static String jsonFileName = 'bookmark.json';

  /// Constructor for creating a BookmarkData instance.
  BookmarkData({
    required this.bookPath,
    required this.bookName,
    required this.chapterTitle,
    required this.chapterFileName,
    this.startCfi,
    required this.savedTime,
  });

  /// Returns the path to the JSON file storing bookmarks.
  static String get jsonPath => join(FilePath.dataRoot, jsonFileName);

  /// Returns the File object for the JSON file storing bookmarks.
  static File get jsonFile => File(jsonPath);

  /// Reads and returns the JSON data from the bookmark file.
  static Map<String, dynamic> get jsonData {
    jsonFile.createSync(recursive: true);

    String jsonString = jsonFile.readAsStringSync();
    jsonString = jsonString.isEmpty ? '{}' : jsonString;

    return jsonDecode(jsonString);
  }

  /// Factory constructor to create a BookmarkData instance from a JSON map.
  factory BookmarkData.fromJson(Map<String, dynamic> map) {
    return BookmarkData(
      bookPath: map['bookPath'] ?? '',
      bookName: map['bookName'] ?? '',
      chapterTitle: map['chapterTitle'] ?? '',
      chapterFileName: map['chapterFileName'] ?? '',
      startCfi: map['startCfi'] ?? '',
      savedTime:
          DateTime.parse(map['savedTime'] ?? DateTime.now().toIso8601String()),
    );
  }

  /// Retrieves a bookmark by its book path.
  static BookmarkData? get(String bookPath) {
    bookPath = FileUtils.getRelativePath(bookPath, FilePath.libraryRoot);
    return jsonData.containsKey(bookPath)
        ? BookmarkData.fromJson(jsonData[bookPath]!)
        : null;
  }

  /// Retrieves a list of all bookmarks.
  static List<BookmarkData> getList() {
    List<BookmarkData> retList = [];

    for (String key in jsonData.keys) {
      if (jsonData.containsKey(key)) {
        final data = BookmarkData.fromJson(jsonData[key]!);

        data.bookPath = FileUtils.getAbsolutePath(
          data.bookPath,
          FilePath.libraryRoot,
        );

        if (File(data.bookPath).existsSync()) {
          retList.add(data);
        } else {
          data.delete();
        }
      }
    }

    return retList;
  }

  /// Saves the current bookmark to the JSON file.
  void save() async {
    final json = jsonData;
    final path = FileUtils.getRelativePath(bookPath, FilePath.libraryRoot);
    json[path] = toJson();
    jsonFile.writeAsStringSync(jsonEncode(json));
  }

  /// Deletes the current bookmark from the JSON file.
  Future<void> delete() async {
    final path = FileUtils.getRelativePath(bookPath, FilePath.libraryRoot);
    jsonData.remove(path);
    jsonFile.writeAsStringSync(jsonEncode(jsonData));
  }

  /// Converts the bookmark data to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'bookPath': bookPath,
      'bookName': bookName,
      'chapterTitle': chapterTitle,
      'chapterFileName': chapterFileName,
      'startCfi': startCfi,
      'savedTime': savedTime.toIso8601String(),
    };
  }

  /// Returns a JSON string representation of the bookmark.
  @override
  String toString() => jsonEncode(toJson());
}
