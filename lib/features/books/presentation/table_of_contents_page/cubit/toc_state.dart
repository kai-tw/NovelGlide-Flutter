import 'package:equatable/equatable.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../../bookmark_service/bookmark_service.dart';
import 'toc_nested_chapter_data.dart';

class TocState extends Equatable {
  const TocState({
    this.code = LoadingStateCode.initial,
    this.bookmarkData,
    this.chapterList = const <TocNestedChapterData>[],
  });

  final LoadingStateCode code;
  final BookmarkData? bookmarkData;
  final List<TocNestedChapterData> chapterList;

  @override
  List<Object?> get props => <Object?>[code, bookmarkData, chapterList];

  TocState copyWith({
    LoadingStateCode? code,
    BookmarkData? bookmarkData,
    List<TocNestedChapterData>? chapterList,
  }) {
    return TocState(
      code: code ?? this.code,
      bookmarkData: bookmarkData ?? this.bookmarkData,
      chapterList: chapterList ?? this.chapterList,
    );
  }
}
