import 'package:equatable/equatable.dart';

import 'book_chapter.dart';
import 'book_cover.dart';

class Book extends Equatable {
  const Book({
    required this.identifier,
    required this.title,
    required this.cover,
    required this.chapterList,
    required this.modifiedDate,
  });

  final String identifier;
  final String title;
  final BookCover cover;
  final List<BookChapter> chapterList;
  final DateTime modifiedDate;

  @override
  List<Object?> get props =>
      <Object?>[identifier, title, cover, chapterList, modifiedDate];
}
