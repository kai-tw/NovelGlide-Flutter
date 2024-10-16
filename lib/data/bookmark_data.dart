import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../toolbox/datetime_utility.dart';
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
    final Map<String, dynamic> json = await jsonData;
    bookPath = isAbsolute(bookPath)
        ? relative(bookPath, from: await FilePath.libraryRoot)
        : bookPath;
    return json.containsKey(bookPath)
        ? BookmarkData.fromJson(json[bookPath]!)
        : null;
  }

  /// Retrieves a list of all bookmarks.
  static Future<List<BookmarkData>> getList() async {
    final Map<String, dynamic> json = await jsonData;
    List<BookmarkData> retList = [];

    for (String key in json.keys) {
      if (json.containsKey(key)) {
        final BookmarkData data = BookmarkData.fromJson(json[key]!);
        data.bookPath = isAbsolute(data.bookPath)
            ? data.bookPath
            : join(await FilePath.libraryRoot, data.bookPath);
        retList.add(data);
      }
    }

    return retList;
  }

  /// Saves the current bookmark to the JSON file.
  void save() async {
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;
    bookPath = isAbsolute(bookPath)
        ? relative(bookPath, from: await FilePath.libraryRoot)
        : bookPath;
    json[bookPath] = toJson();
    dataFile.writeAsStringSync(jsonEncode(json));
  }

  /// Deletes the current bookmark from the JSON file.
  Future<void> delete() async {
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;
    json.remove(bookPath);
    dataFile.writeAsStringSync(jsonEncode(json));
  }

  /// Creates a copy of the current bookmark with optional new values.
  BookmarkData copyWith({
    String? bookPath,
    String? bookName,
    String? chapterTitle,
    String? chapterFileName,
    String? startCfi,
    DateTime? savedTime,
  }) {
    return BookmarkData(
      bookPath: bookPath ?? this.bookPath,
      bookName: bookName ?? this.bookName,
      chapterTitle: chapterTitle ?? this.chapterTitle,
      chapterFileName: chapterFileName ?? this.chapterFileName,
      startCfi: startCfi ?? this.startCfi,
      savedTime: savedTime ?? this.savedTime,
    );
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
