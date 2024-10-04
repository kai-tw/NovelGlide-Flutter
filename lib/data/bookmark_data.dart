import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../toolbox/datetime_utility.dart';
import '../toolbox/file_path.dart';

class BookmarkData {
  String bookPath;
  final String bookName;
  final String chapterTitle;
  final String chapterFileName;
  final String? startCfi;
  final DateTime savedTime;

  int get daysPassed => DateTimeUtility.daysPassed(savedTime);

  BookmarkData({
    required this.bookPath,
    required this.bookName,
    required this.chapterTitle,
    required this.chapterFileName,
    this.startCfi,
    required this.savedTime,
  });

  static Future<String> get jsonPath async => join(await FilePath.dataRoot, 'bookmark.json');

  static Future<File> get jsonFile async => File(await jsonPath);

  static Future<Map<String, dynamic>> get jsonData async {
    final File dataFile = await jsonFile;
    dataFile.createSync(recursive: true);

    String jsonString = dataFile.readAsStringSync();
    jsonString = jsonString.isEmpty ? '{}' : jsonString;

    return jsonDecode(jsonString);
  }

  factory BookmarkData.fromJson(Map<String, dynamic> map) {
    return BookmarkData(
      bookPath: map['bookPath'] ?? '',
      bookName: map['bookName'] ?? '',
      chapterTitle: map['chapterTitle'] ?? '',
      chapterFileName: map['chapterFileName'] ?? '',
      startCfi: map['startCfi'] ?? '',
      savedTime: DateTime.parse(map['savedTime'] ?? DateTime.now().toIso8601String()),
    );
  }

  static Future<BookmarkData?> get(String bookPath) async {
    final Map<String, dynamic> json = await jsonData;
    bookPath = isAbsolute(bookPath) ? relative(bookPath, from: await FilePath.libraryRoot) : bookPath;
    return json.containsKey(bookPath) ? BookmarkData.fromJson(json[bookPath]!) : null;
  }

  static Future<List<BookmarkData>> getList() async {
    final Map<String, dynamic> json = await jsonData;
    List<BookmarkData> retList = [];

    for (String key in json.keys) {
      if (json.containsKey(key)) {
        final BookmarkData data = BookmarkData.fromJson(json[key]!);
        data.bookPath = isAbsolute(data.bookPath) ? data.bookPath : join(await FilePath.libraryRoot, data.bookPath);
        retList.add(data);
      }
    }

    return retList;
  }

  void save() async {
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;
    bookPath = isAbsolute(bookPath) ? relative(bookPath, from: await FilePath.libraryRoot) : bookPath;
    json[bookPath] = toJson();
    dataFile.writeAsStringSync(jsonEncode(json));
  }

  Future<void> delete() async {
    final File dataFile = await jsonFile;
    final Map<String, dynamic> json = await jsonData;
    json.remove(bookPath);
    dataFile.writeAsStringSync(jsonEncode(json));
  }

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

  @override
  String toString() => jsonEncode(toJson());
}
