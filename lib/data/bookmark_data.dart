import 'dart:convert';

import 'package:hive/hive.dart';

import '../toolbox/datetime_utility.dart';

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

  static BookmarkData? get(String bookPath) {
    final Box<Map<String, dynamic>> box = Hive.box(name: 'bookmark');
    return box.get(bookPath) != null ? BookmarkData.fromJson(box.get(bookPath)!) : null;
  }

  static List<BookmarkData> getList() {
    final Box<Map<String, dynamic>> box = Hive.box(name: 'bookmark');
    List<BookmarkData> retList = [];

    for (String key in box.keys) {
      if (box.get(key) != null) {
        retList.add(BookmarkData.fromJson(box.get(key)!));
      }
    }

    box.close();

    return retList;
  }

  void save() {
    final Box<Map<String, dynamic>?> box = Hive.box(name: 'bookmark');
    box.put(bookPath, toJson());
    box.close();
  }

  void delete() {
    final Box<Map<String, dynamic>?> box = Hive.box(name: 'bookmark');
    box.delete(bookPath);
    box.close();
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
