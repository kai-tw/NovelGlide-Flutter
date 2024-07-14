import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../data/chapter_data.dart';
import '../../../processor/book_processor.dart';
import '../../../processor/chapter_processor.dart';

enum TocStateCode { loading, normal, empty }

class TocCubit extends Cubit<TocState> {
  TocCubit(BookData bookData) : super(TocState(bookName: bookData.name));

  void refresh({BookData? newData}) async {
    final String bookName = newData?.name ?? state.bookName;
    final List<ChapterData> chapterList = ChapterProcessor.getList(bookName);
    final TocStateCode code = chapterList.isEmpty ? TocStateCode.empty : TocStateCode.normal;
    final BookmarkData bookmarkData = BookmarkData.loadFromBookName(bookName);
    emit(state.copyWith(
      bookName: bookName,
      isCoverExist: BookProcessor.isCoverExist(bookName),
      code: code,
      chapterList: chapterList,
      bookmarkData: bookmarkData,
    ));
  }

  void setDirty() {
    emit(state.copyWith(isDirty: true));
  }

  void setDragging(bool isDragging) {
    emit(state.copyWith(isDragging: isDragging));
  }
}

class TocState extends Equatable {
  final bool isDirty;
  final String bookName;
  final bool isCoverExist;
  final TocStateCode code;
  final List<ChapterData> chapterList;
  final bool isDragging;
  final BookmarkData bookmarkData;

  @override
  List<Object?> get props => [
        isDirty,
        bookName,
        isCoverExist,
        code,
        chapterList,
        isDragging,
    bookmarkData,
      ];

  TocState({
    this.isDirty = false,
    this.bookName = "",
    this.isCoverExist = false,
    this.code = TocStateCode.loading,
    this.chapterList = const [],
    this.isDragging = false,
    BookmarkData? bookmarkData,
  }) : bookmarkData = bookmarkData ?? BookmarkData();

  TocState copyWith({
    bool? isDirty,
    String? bookName,
    bool? isCoverExist,
    TocStateCode? code,
    List<ChapterData>? chapterList,
    bool? isDragging,
    BookmarkData? bookmarkData,
  }) {
    return TocState(
      isDirty: isDirty ?? this.isDirty,
      bookName: bookName ?? this.bookName,
      isCoverExist: isCoverExist ?? this.isCoverExist,
      code: code ?? this.code,
      chapterList: chapterList ?? this.chapterList,
      isDragging: isDragging ?? this.isDragging,
      bookmarkData: bookmarkData ?? this.bookmarkData,
    );
  }
}
