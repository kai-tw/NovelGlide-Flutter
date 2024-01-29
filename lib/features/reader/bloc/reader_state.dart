import 'package:equatable/equatable.dart';

import '../../../shared/bookmark_object.dart';
import '../../../shared/chapter_object.dart';
import 'reader_settings.dart';

class ReaderState extends Equatable {
  final ChapterObject chapterObject;
  final ChapterObject? prevChapterObj;
  final ChapterObject? nextChapterObj;

  final ReaderSettings readerSettings;

  final bool isJumpToBookmarkDisabled;
  final bool isAddBookmarkDisabled;

  const ReaderState({
    required this.chapterObject,
    this.prevChapterObj,
    this.nextChapterObj,
    this.isAddBookmarkDisabled = false,
    this.isJumpToBookmarkDisabled = false,
    ReaderSettings? readerSettings,
    BookmarkObject? bookmarkObject,
  })  : readerSettings = readerSettings ?? const ReaderSettings();

  ReaderState copyWith({
    ChapterObject? prevChapterObj,
    ChapterObject? nextChapterObj,
    ReaderSettings? readerSettings,
    bool? isBookmarkShow,
    bool? isAddBookmarkDisabled,
    BookmarkObject? bookmarkObject,
  }) {
    return ReaderState(
      chapterObject: chapterObject,
      prevChapterObj: prevChapterObj ?? this.prevChapterObj,
      nextChapterObj: nextChapterObj ?? this.nextChapterObj,
      readerSettings: readerSettings ?? this.readerSettings,
      isAddBookmarkDisabled: isAddBookmarkDisabled ?? this.isAddBookmarkDisabled,
    );
  }

  @override
  List<Object?> get props => [
        prevChapterObj,
        nextChapterObj,
        readerSettings,
        isAddBookmarkDisabled,
      ];
}
