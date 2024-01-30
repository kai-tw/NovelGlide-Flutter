import 'package:equatable/equatable.dart';

import '../../../shared/bookmark_object.dart';
import '../../../shared/chapter_object.dart';
import 'reader_button_state.dart';
import 'reader_settings.dart';

class ReaderState extends Equatable {
  final ChapterObject chapterObject;
  final ChapterObject? prevChapterObj;
  final ChapterObject? nextChapterObj;

  final BookmarkObject bookmarkObject;
  final ReaderSettings readerSettings;
  final RdrBtnState buttonState;

  ReaderState({
    required this.chapterObject,
    this.prevChapterObj,
    this.nextChapterObj,
    BookmarkObject? bookmarkObject,
    ReaderSettings? readerSettings,
    RdrBtnState? buttonState,
  })  : readerSettings = readerSettings ?? const ReaderSettings(),
        buttonState = buttonState ?? const RdrBtnState(),
        bookmarkObject = bookmarkObject ?? BookmarkObject();

  ReaderState copyWith({
    ChapterObject? prevChapterObj,
    ChapterObject? nextChapterObj,
    BookmarkObject? bookmarkObject,
    ReaderSettings? readerSettings,
    RdrBtnState? buttonState,
  }) {
    return ReaderState(
      chapterObject: chapterObject,
      prevChapterObj: prevChapterObj ?? this.prevChapterObj,
      nextChapterObj: nextChapterObj ?? this.nextChapterObj,
      bookmarkObject: bookmarkObject ?? this.bookmarkObject,
      readerSettings: readerSettings ?? this.readerSettings,
      buttonState: buttonState ?? this.buttonState,
    );
  }

  @override
  List<Object?> get props => [
        prevChapterObj,
        nextChapterObj,
        bookmarkObject,
        readerSettings,
        buttonState,
      ];
}
