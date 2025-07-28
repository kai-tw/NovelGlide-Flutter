part of '../table_of_contents.dart';

class TocState extends Equatable {
  const TocState({
    this.code = LoadingStateCode.initial,
    this.bookmarkData,
    this.chapterList = const <ChapterData>[],
  });

  final LoadingStateCode code;
  final BookmarkData? bookmarkData;
  final List<ChapterData> chapterList;

  @override
  List<Object?> get props => <Object?>[code, bookmarkData, chapterList];

  TocState copyWith({
    LoadingStateCode? code,
    BookmarkData? bookmarkData,
    List<ChapterData>? chapterList,
  }) {
    return TocState(
      code: code ?? this.code,
      bookmarkData: bookmarkData ?? this.bookmarkData,
      chapterList: chapterList ?? this.chapterList,
    );
  }
}
