import 'package:equatable/equatable.dart';

import '../../../shared/chapter_object.dart';
import 'reader_settings.dart';

class ReaderState extends Equatable {
  final ChapterObject chapterObject;
  final ChapterObject? prevChapterObj;
  final ChapterObject? nextChapterObj;
  final ReaderSettings readerSettings;
  final bool addBookmarkState;

  const ReaderState({
    required this.chapterObject,
    this.prevChapterObj,
    this.nextChapterObj,
    ReaderSettings? readerSettings,
    this.addBookmarkState = false,
  }) : readerSettings = readerSettings ?? const ReaderSettings();

  ReaderState copyWith({
    ChapterObject? prevChapterObj,
    ChapterObject? nextChapterObj,
    ReaderSettings? readerSettings,
    bool? addBookmarkState,
  }) {
    return ReaderState(
      chapterObject: chapterObject,
      prevChapterObj: prevChapterObj ?? this.prevChapterObj,
      nextChapterObj: nextChapterObj ?? this.nextChapterObj,
      readerSettings: readerSettings ?? this.readerSettings,
      addBookmarkState: addBookmarkState ?? this.addBookmarkState,
    );
  }

  @override
  List<Object?> get props => [prevChapterObj, nextChapterObj, readerSettings, addBookmarkState];
}
