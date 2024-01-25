import 'package:equatable/equatable.dart';

import '../../../shared/chapter_object.dart';

class ReaderState extends Equatable {
  final ChapterObject chapterObject;
  final ChapterObject? prevChapterObj;
  final ChapterObject? nextChapterObj;

  final double fontSize;
  static const double minFontSize = 12;
  static const double maxFontSize = 32;

  final double lineHeight;
  static const double minLineHeight = 1;
  static const double maxLineHeight = 3;

  const ReaderState({
    required this.chapterObject,
    this.fontSize = 16,
    this.lineHeight = 1.2,
    this.prevChapterObj,
    this.nextChapterObj,
  });

  ReaderState copyWith({
    ChapterObject? prevChapterObj,
    ChapterObject? nextChapterObj,
    double? fontSize,
    double? lineHeight,
  }) {
    return ReaderState(
      chapterObject: chapterObject,
      prevChapterObj: prevChapterObj ?? this.prevChapterObj,
      nextChapterObj: nextChapterObj ?? this.nextChapterObj,
      fontSize: (fontSize ?? this.fontSize).clamp(minFontSize, maxFontSize),
      lineHeight: (lineHeight ?? this.lineHeight).clamp(minLineHeight, maxLineHeight),
    );
  }

  @override
  List<Object?> get props => [prevChapterObj, nextChapterObj, fontSize, lineHeight];
}
