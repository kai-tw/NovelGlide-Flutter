part of '../bookmark_service.dart';

class BookmarkData extends Equatable {
  const BookmarkData({
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

  final String bookPath;
  final String bookName;
  final String chapterTitle;
  final String chapterFileName;
  final String? startCfi;
  final DateTime savedTime;

  @override
  List<Object?> get props => <Object?>[
        bookPath,
        bookName,
        chapterTitle,
        chapterFileName,
        startCfi,
        savedTime,
      ];

  /// Calculates the number of days passed since the bookmark was saved.
  int get daysPassed => DateTime.now().difference(savedTime).inDays;

  /// Converts the bookmark data to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
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

  /// Copy with new values.
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
}
