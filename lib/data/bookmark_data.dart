import 'dart:convert';

import 'package:hive/hive.dart';

import '../processor/bookmark_processor.dart';
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

  void save() {
    final Box<String> box = Hive.box(name: 'bookmark');
    box.put(bookPath, jsonEncode(toJson()));
    box.close();
  }

  void delete() => BookmarkProcessor.delete(bookPath);

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
