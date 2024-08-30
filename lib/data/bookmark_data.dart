import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';

import '../toolbox/datetime_utility.dart';

class BookmarkData {
  final String bookPath;
  final String bookName;
  final String? startCfi;
  final DateTime savedTime;

  int get daysPassed => DateTimeUtility.daysPassed(savedTime);

  BookmarkData({
    required this.bookPath,
    required this.bookName,
    this.startCfi,
    required this.savedTime,
  });

  factory BookmarkData.fromMap(Map<String, dynamic> map) {
    return BookmarkData(
      bookPath: map['bookPath'] ?? '',
      bookName: map['bookName'] ?? '',
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

  static Future<List<BookmarkData>> getList() async {
    final Box<String> box = Hive.box(name: 'bookmark');
    List<BookmarkData> retList = [];

    for (int i = 0; i < box.length; i++) {
      final BookmarkData data = BookmarkData.fromJson(box.getAt(i));
      if (File(data.bookPath).existsSync()) {
        retList.add(data);
      } else {
        box.deleteAt(i);
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
    String? startCfi,
    DateTime? savedTime,
  }) {
    return BookmarkData(
      bookPath: bookPath ?? this.bookPath,
      bookName: bookName ?? this.bookName,
      startCfi: startCfi ?? this.startCfi,
      savedTime: savedTime ?? this.savedTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookPath': bookPath,
      'bookName': bookName,
      'startCfi': startCfi,
      'savedTime': savedTime.toIso8601String(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
