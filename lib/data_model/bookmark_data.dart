import 'dart:convert';

import '../utils/datetime_utils.dart';

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

  /// Constructor for creating a BookmarkData instance.
  BookmarkData({
    required this.bookPath,
    required this.bookName,
    required this.chapterTitle,
    required this.chapterFileName,
    this.startCfi,
    required this.savedTime,
  });

  /// Factory constructor to create a BookmarkData instance from a JSON map.
  factory BookmarkData.fromJson(Map<String, dynamic> map) {
    return BookmarkData(
      bookPath: map['bookPath'] ?? '',
      bookName: map['bookName'] ?? '',
      chapterTitle: map['chapterTitle'] ?? '',
      chapterFileName: map['chapterFileName'] ?? '',
      startCfi: map['startCfi'],
      savedTime: map['savedTime'] != null
          ? DateTime.parse(map['savedTime'])
          : DateTime.now(),
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BookmarkData) return false;

    return other.bookPath == bookPath &&
        other.chapterTitle == chapterTitle &&
        other.chapterFileName == chapterFileName &&
        other.startCfi == startCfi &&
        other.savedTime == savedTime;
  }

  @override
  int get hashCode =>
      bookPath.hashCode ^
      chapterTitle.hashCode ^
      chapterFileName.hashCode ^
      startCfi.hashCode ^
      savedTime.hashCode;
}
