import 'dart:convert';

import 'package:hive/hive.dart';

import '../toolbox/datetime_utility.dart';

class BookmarkData {
  final String bookPath;
  final String bookName;
  final String chapterTitle;
  final String? startCfi;
  final DateTime savedTime;

  int get daysPassed => DateTimeUtility.daysPassed(savedTime);

  BookmarkData({
    required this.bookPath,
    required this.bookName,
    required this.chapterTitle,
    this.startCfi,
    required this.savedTime,
  });

  factory BookmarkData.fromMap(Map<String, dynamic> map) {
    return BookmarkData(
      bookPath: map['bookPath'] ?? '',
      bookName: map['bookName'] ?? '',
      chapterTitle: map['chapterTitle'] ?? '',
      startCfi: map['startCfi'] ?? '',
      savedTime: DateTime.parse(map['savedTime'] ?? DateTime.now().toIso8601String()),
    );
  }

  factory BookmarkData.fromJson(String json) => BookmarkData.fromMap(jsonDecode(json));

  static BookmarkData? get(String bookPath) {
    final Box<String> box = Hive.box(name: 'bookmark');
    final String? jsonValue = box.get(bookPath);
    if (jsonValue != null) {
      return BookmarkData.fromJson(jsonValue);
    }
    return null;
  }

  static List<BookmarkData> getList() {
    final Box<String> box = Hive.box(name: 'bookmark');
    List<BookmarkData> retList = [];

    for (String key in box.keys) {
      final String? rawJson = box.get(key);
      if (rawJson == null) {
        box.delete(key);
      } else {
        retList.add(BookmarkData.fromJson(rawJson));
      }
    }

    box.close();

    return retList;
  }

  void save() {
    final Box<String> box = Hive.box(name: 'bookmark');
    box.put(bookPath, jsonEncode(toJson()));
    box.close();
  }

  void delete() {
    final Box<String> box = Hive.box(name: 'bookmark');
    box.delete(bookPath);
    box.close();
  }

  BookmarkData copyWith({
    String? bookPath,
    String? bookName,
    String? chapterTitle,
    String? startCfi,
    DateTime? savedTime,
  }) {
    return BookmarkData(
      bookPath: bookPath ?? this.bookPath,
      bookName: bookName ?? this.bookName,
      chapterTitle: chapterTitle ?? this.chapterTitle,
      startCfi: startCfi ?? this.startCfi,
      savedTime: savedTime ?? this.savedTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookPath': bookPath,
      'bookName': bookName,
      'chapterTitle': chapterTitle,
      'startCfi': startCfi,
      'savedTime': savedTime.toIso8601String(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
