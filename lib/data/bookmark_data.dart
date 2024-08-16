import 'dart:convert';

import '../processor/bookmark_processor.dart';
import '../toolbox/datetime_utility.dart';

class BookmarkData {
  final String bookName;
  final int chapterNumber;
  final double scrollPosition;
  final DateTime savedTime;

  int get daysPassed => DateTimeUtility.daysPassed(savedTime);

  BookmarkData({
    this.bookName = '',
    this.chapterNumber = 0,
    this.scrollPosition = 0.0,
    DateTime? savedTime,
  })  : savedTime = savedTime ?? DateTime.now();

  BookmarkData.fromMap(Map<String, dynamic> map)
      : this(
          bookName: map['bookName'] ?? '',
          chapterNumber: map['chapterNumber'] ?? 0,
          scrollPosition: map['scrollPosition'] ?? 0.0,
          savedTime: DateTime.parse(map['savedTime'] ?? DateTime.now().toIso8601String()),
        );

  BookmarkData.fromJson(String json) : this.fromMap(jsonDecode(json));

  void save() {
    BookmarkProcessor.save(this);
  }

  void clear() {
    BookmarkProcessor.delete(bookName);
  }

  BookmarkData copyWith({
    String? bookName,
    int? chapterNumber,
    double? scrollPosition,
    DateTime? savedTime,
  }) {
    return BookmarkData(
      bookName: bookName ?? this.bookName,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      scrollPosition: scrollPosition ?? this.scrollPosition,
      savedTime: savedTime ?? this.savedTime,
    );
  }

  @override
  String toString() {
    return '{ bookName: $bookName, chapterNumber: $chapterNumber, area: $scrollPosition, savedTime: $savedTime, daysPassed: $daysPassed }';
  }

  String toJson() {
    final Map<String, dynamic> map = {
      'bookName': bookName,
      'chapterNumber': chapterNumber,
      'scrollPosition': scrollPosition,
      'savedTime': savedTime.toIso8601String(),
    };
    return jsonEncode(map);
  }
}
