part of '../../bookmark_service.dart';

class BookmarkData extends Equatable {
  const BookmarkData({
    required this.bookPath,
    required this.bookName,
    required this.chapterTitle,
    required this.chapterFileName,
    required this.startCfi,
    required this.savedTime,
  });

  factory BookmarkData.fromJson(Map<String, dynamic> json) {
    return BookmarkData(
      bookPath: json['bookPath'] ?? '',
      bookName: json['bookName'] ?? '',
      chapterTitle: json['chapterTitle'] ?? '',
      chapterFileName: json['chapterFileName'] ?? '',
      startCfi: json['startCfi'],
      savedTime: json['savedTime'] != null
          ? DateTime.parse(json['savedTime'])
          : DateTime.now(),
    );
  }

  final String bookPath;
  final String bookName;
  final String chapterTitle;
  final String chapterFileName;
  final String startCfi;
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
