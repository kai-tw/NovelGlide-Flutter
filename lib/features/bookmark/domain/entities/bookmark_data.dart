import 'package:equatable/equatable.dart';

class BookmarkData extends Equatable {
  const BookmarkData({
    required this.bookIdentifier,
    required this.bookName,
    required this.chapterTitle,
    required this.chapterIdentifier,
    required this.startCfi,
    required this.savedTime,
  });

  factory BookmarkData.fromJson(Map<String, dynamic> json) {
    return BookmarkData(
      bookIdentifier: json['bookPath'] ?? '',
      bookName: json['bookName'] ?? '',
      chapterTitle: json['chapterTitle'] ?? '',
      chapterIdentifier: json['chapterFileName'] ?? '',
      startCfi: json['startCfi'],
      savedTime: json['savedTime'] != null
          ? DateTime.parse(json['savedTime'])
          : DateTime.now(),
    );
  }

  final String bookIdentifier;
  final String bookName;
  final String chapterTitle;
  final String chapterIdentifier;
  final String startCfi;
  final DateTime savedTime;

  @override
  List<Object?> get props => <Object?>[
        bookIdentifier,
        bookName,
        chapterTitle,
        chapterIdentifier,
        startCfi,
        savedTime,
      ];

  /// Calculates the number of days passed since the bookmark was saved.
  int get daysPassed => DateTime.now().difference(savedTime).inDays;

  /// Converts the bookmark data to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'bookPath': bookIdentifier,
      'bookName': bookName,
      'chapterTitle': chapterTitle,
      'chapterFileName': chapterIdentifier,
      'startCfi': startCfi,
      'savedTime': savedTime.toIso8601String(),
    };
  }
}
