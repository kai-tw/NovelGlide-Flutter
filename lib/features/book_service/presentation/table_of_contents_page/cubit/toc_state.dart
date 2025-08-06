part of '../table_of_contents.dart';

class TocState extends Equatable {
  const TocState({
    this.code = LoadingStateCode.initial,
    this.bookmarkData,
    this.chapterList = const <BookChapter>[],
  });

  final LoadingStateCode code;
  final BookmarkData? bookmarkData;
  final List<BookChapter> chapterList;

  @override
  List<Object?> get props => <Object?>[code, bookmarkData, chapterList];

  TocState copyWith({
    LoadingStateCode? code,
    BookmarkData? bookmarkData,
    List<BookChapter>? chapterList,
  }) {
    return TocState(
      code: code ?? this.code,
      bookmarkData: bookmarkData ?? this.bookmarkData,
      chapterList: chapterList ?? this.chapterList,
    );
  }
}
