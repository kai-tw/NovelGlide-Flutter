import 'package:equatable/equatable.dart';

import '../../../shared/chapter_object.dart';
import 'reader_settings.dart';

class ReaderState extends Equatable {
  final ChapterObject chapterObject;
  final ChapterObject? prevChapterObj;
  final ChapterObject? nextChapterObj;
  final ReaderSettings readerSettings;

  const ReaderState({
    required this.chapterObject,
    this.prevChapterObj,
    this.nextChapterObj,
    ReaderSettings? readerSettings,
  }) : readerSettings = readerSettings ?? const ReaderSettings();

  ReaderState copyWith({
    ChapterObject? prevChapterObj,
    ChapterObject? nextChapterObj,
    ReaderSettings? readerSettings,
  }) {
    return ReaderState(
      chapterObject: chapterObject,
      prevChapterObj: prevChapterObj ?? this.prevChapterObj,
      nextChapterObj: nextChapterObj ?? this.nextChapterObj,
      readerSettings: readerSettings ?? this.readerSettings,
    );
  }

  @override
  List<Object?> get props => [prevChapterObj, nextChapterObj, readerSettings];
}
