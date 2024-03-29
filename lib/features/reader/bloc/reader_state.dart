import 'package:equatable/equatable.dart';

import '../../../shared/bookmark_object.dart';
import 'reader_button_state.dart';
import 'reader_settings.dart';

enum ReaderStateCode { loading, loaded }

class ReaderState extends Equatable {
  final ReaderStateCode code;
  final String bookName;
  final int chapterNumber;
  final int prevChapterNumber;
  final int nextChapterNumber;
  final List<String> contentLines;
  final BookmarkObject bookmarkObject;
  final ReaderSettings readerSettings;
  final RdrBtnState buttonState;

  ReaderState({
    this.code = ReaderStateCode.loading,
    required this.bookName,
    required this.chapterNumber,
    this.prevChapterNumber = -1,
    this.nextChapterNumber = -1,
    this.contentLines = const [],
    BookmarkObject? bookmarkObject,
    ReaderSettings? readerSettings,
    RdrBtnState? buttonState,
  })  : readerSettings = readerSettings ?? const ReaderSettings(),
        buttonState = buttonState ?? const RdrBtnState.disabledAll(),
        bookmarkObject = bookmarkObject ?? BookmarkObject();

  ReaderState copyWith({
    ReaderStateCode? code,
    String? bookName,
    int? chapterNumber,
    int? prevChapterNumber,
    int? nextChapterNumber,
    List<String>? contentLines,
    BookmarkObject? bookmarkObject,
    ReaderSettings? readerSettings,
    RdrBtnState? buttonState,
  }) {
    return ReaderState(
      code: code ?? this.code,
      bookName: bookName ?? this.bookName,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      prevChapterNumber: prevChapterNumber ?? this.prevChapterNumber,
      nextChapterNumber: nextChapterNumber ?? this.nextChapterNumber,
      contentLines: contentLines ?? this.contentLines,
      bookmarkObject: bookmarkObject ?? this.bookmarkObject,
      readerSettings: readerSettings ?? this.readerSettings,
      buttonState: buttonState ?? this.buttonState,
    );
  }

  @override
  List<Object?> get props => [
        bookName,
        chapterNumber,
        prevChapterNumber,
        nextChapterNumber,
        contentLines,
        bookmarkObject,
        readerSettings,
        buttonState,
      ];
}
