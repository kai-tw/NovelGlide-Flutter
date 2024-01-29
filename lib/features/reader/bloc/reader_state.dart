import 'package:equatable/equatable.dart';

import '../../../shared/bookmark_object.dart';
import '../../../shared/chapter_object.dart';
import 'reader_button_state.dart';
import 'reader_settings.dart';

class ReaderState extends Equatable {
  final ChapterObject chapterObject;
  final ChapterObject? prevChapterObj;
  final ChapterObject? nextChapterObj;

  final ReaderSettings readerSettings;
  final RdrBtnState buttonState;

  const ReaderState({
    required this.chapterObject,
    this.prevChapterObj,
    this.nextChapterObj,
    ReaderSettings? readerSettings,
    RdrBtnState? buttonState,
    BookmarkObject? bookmarkObject,
  })  : readerSettings = readerSettings ?? const ReaderSettings(),
        buttonState = buttonState ?? const RdrBtnState();

  ReaderState copyWith({
    ChapterObject? prevChapterObj,
    ChapterObject? nextChapterObj,
    ReaderSettings? readerSettings,
    RdrBtnState? buttonState,
    BookmarkObject? bookmarkObject,
  }) {
    return ReaderState(
      chapterObject: chapterObject,
      prevChapterObj: prevChapterObj ?? this.prevChapterObj,
      nextChapterObj: nextChapterObj ?? this.nextChapterObj,
      readerSettings: readerSettings ?? this.readerSettings,
      buttonState: buttonState ?? this.buttonState,
    );
  }

  @override
  List<Object?> get props => [
        prevChapterObj,
        nextChapterObj,
        readerSettings,
        buttonState,
      ];
}
