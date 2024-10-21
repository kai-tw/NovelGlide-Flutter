import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../toolbox/datetime_utility.dart';
import '../toolbox/file_helper.dart';
import '../toolbox/file_path.dart';

/// Represents a bookmark with its metadata and operations.
class BookmarkData {
  String bookPath;
  final String bookName;
  final String chapterTitle;
  final String chapterFileName;
  final String? startCfi;
  final DateTime savedTime;

  /// Calculates the number of days passed since the bookmark was saved.
  int get daysPassed => DateTimeUtility.daysPassed(savedTime);

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
  static Future<String> get jsonPath async =>
      join(await FilePath.dataRoot, jsonFileName);

  /// Returns the File object for the JSON file storing bookmarks.
  static Future<File> get jsonFile async => File(await jsonPath);

  /// Reads and returns the JSON data from the bookmark file.
  static Future<Map<String, dynamic>> get jsonData async {
    final File dataFile = await jsonFile;
    dataFile.createSync(recursive: true);

    String jsonString = dataFile.readAsStringSync();
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
  static Future<BookmarkData?> get(String bookPath) async {
    final json = await jsonData;
    bookPath = FileHelper.getRelativePath(bookPath, await FilePath.libraryRoot);
    return json.containsKey(bookPath)
        ? BookmarkData.fromJson(json[bookPath]!)
        : null;
  }

  /// Retrieves a list of all bookmarks.
  static Future<List<BookmarkData>> getList() async {
    final json = await jsonData;
    List<BookmarkData> retList = [];

    for (String key in json.keys) {
      if (json.containsKey(key)) {
        final data = BookmarkData.fromJson(json[key]!);

        data.bookPath = FileHelper.getAbsolutePath(
          data.bookPath,
          await FilePath.libraryRoot,
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
    final dataFile = await jsonFile;
    final json = await jsonData;
    final path = FileHelper.getRelativePath(bookPath, await FilePath.libraryRoot);
    json[path] = toJson();
    dataFile.writeAsStringSync(jsonEncode(json));
  }

  /// Deletes the current bookmark from the JSON file.
  Future<void> delete() async {
    final dataFile = await jsonFile;
    Map<String, dynamic> json = await jsonData;
    final path = FileHelper.getRelativePath(bookPath, await FilePath.libraryRoot);
    json.remove(path);
    dataFile.writeAsStringSync(jsonEncode(json));
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
