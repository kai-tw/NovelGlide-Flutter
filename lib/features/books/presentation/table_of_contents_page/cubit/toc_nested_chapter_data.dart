import 'package:equatable/equatable.dart';

import '../../../domain/entities/book_chapter.dart';

class TocNestedChapterData extends Equatable {
  const TocNestedChapterData({
    required this.chapterData,
    required this.nestedLevel,
  });

  final BookChapter chapterData;
  final int nestedLevel;

  @override
  List<Object?> get props => <Object?>[chapterData, nestedLevel];
}
