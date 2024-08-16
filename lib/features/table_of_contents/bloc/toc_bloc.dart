import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../data/chapter_data.dart';
import '../../../processor/book_processor.dart';
import '../../../processor/bookmark_processor.dart';
import '../../../processor/chapter_processor.dart';

enum TocStateCode { loading, normal, empty }

class TocCubit extends Cubit<TocState> {
  final PageStorageBucket bucket = PageStorageBucket();

  TocCubit(BookData bookData) : super(TocState(bookName: bookData.name));

  Future<void> refresh({BookData? newData}) async {
    // After the UI is rendered, start to load the data.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final String bookName = newData?.name ?? state.bookName;
      final List<ChapterData> chapterList = await ChapterProcessor.getList(bookName);
      final TocStateCode code = chapterList.isEmpty ? TocStateCode.empty : TocStateCode.normal;
      emit(TocState(
        bookName: bookName,
        isCoverExist: BookProcessor.isCoverExist(bookName),
        code: code,
        chapterList: chapterList,
        bookmarkData: BookmarkProcessor.get(bookName),
      ));
    });
  }

  void setDragging(bool isDragging) {
    emit(state.copyWith(isDragging: isDragging));
  }
}

class TocState extends Equatable {
  final String bookName;
  final bool isCoverExist;
  final TocStateCode code;
  final List<ChapterData> chapterList;
  final bool isDragging;
  final BookmarkData? bookmarkData;

  @override
  List<Object?> get props => [
        bookName,
        isCoverExist,
        code,
        chapterList,
        isDragging,
        bookmarkData,
      ];

  const TocState({
    this.bookName = "",
    this.isCoverExist = false,
    this.code = TocStateCode.loading,
    this.chapterList = const [],
    this.isDragging = false,
    this.bookmarkData,
  });

  TocState copyWith({
    String? bookName,
    bool? isCoverExist,
    TocStateCode? code,
    List<ChapterData>? chapterList,
    bool? isDragging,
    BookmarkData? bookmarkData,
  }) {
    return TocState(
      bookName: bookName ?? this.bookName,
      isCoverExist: isCoverExist ?? this.isCoverExist,
      code: code ?? this.code,
      chapterList: chapterList ?? this.chapterList,
      isDragging: isDragging ?? this.isDragging,
      bookmarkData: bookmarkData ?? this.bookmarkData,
    );
  }
}
