import 'package:equatable/equatable.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/reader_settings_data.dart';

enum ReaderStateCode { loading, loaded }

class ReaderState extends Equatable {
  /// Overall state.
  final ReaderStateCode code;
  final String bookName;
  final int chapterNumber;
  final int prevChapterNumber;
  final int nextChapterNumber;
  final List<String> contentLines;
  final BookmarkData bookmarkData;

  /// Settings state.
  final ReaderSettingsData readerSettings;

  @override
  List<Object?> get props => [
    bookName,
    chapterNumber,
    prevChapterNumber,
    nextChapterNumber,
    contentLines,
    bookmarkData,
    readerSettings,
  ];

  ReaderState({
    this.code = ReaderStateCode.loading,
    required this.bookName,
    required this.chapterNumber,
    this.prevChapterNumber = -1,
    this.nextChapterNumber = -1,
    this.contentLines = const [],
    BookmarkData? bookmarkData,
    ReaderSettingsData? readerSettings,
  })  : readerSettings = readerSettings ?? const ReaderSettingsData(),
        bookmarkData = bookmarkData ?? BookmarkData();

  ReaderState copyWith({
    ReaderStateCode? code,
    String? bookName,
    int? chapterNumber,
    int? prevChapterNumber,
    int? nextChapterNumber,
    List<String>? contentLines,
    BookmarkData? bookmarkData,
    ReaderSettingsData? readerSettings,
  }) {
    return ReaderState(
      code: code ?? this.code,
      bookName: bookName ?? this.bookName,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      prevChapterNumber: prevChapterNumber ?? this.prevChapterNumber,
      nextChapterNumber: nextChapterNumber ?? this.nextChapterNumber,
      contentLines: contentLines ?? this.contentLines,
      bookmarkData: bookmarkData ?? this.bookmarkData,
      readerSettings: readerSettings ?? this.readerSettings,
    );
  }

}
