import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../data/chapter_data.dart';
import '../../../enum/loading_state_code.dart';

class TocCubit extends Cubit<TocState> {
  final PageStorageBucket bucket = PageStorageBucket();
  final ScrollController scrollController = ScrollController();
  BookData bookData;

  TocCubit(this.bookData) : super(const TocState());

  Future<void> init() async {
    emit(const TocState(code: LoadingStateCode.loading));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      emit(TocState(
        code: LoadingStateCode.loaded,
        bookmarkData: BookmarkData.get(bookData.filePath),
        chapterList: await bookData.getChapterList(),
      ));
    });
  }

  void refresh() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      emit(TocState(
        code: LoadingStateCode.loaded,
        bookmarkData: BookmarkData.get(bookData.filePath),
        chapterList: state.chapterList,
      ));
    });
  }
}

class TocState extends Equatable {
  final LoadingStateCode code;
  final BookmarkData? bookmarkData;
  final List<ChapterData> chapterList;

  @override
  List<Object?> get props => [code, bookmarkData, chapterList];

  const TocState({
    this.code = LoadingStateCode.initial,
    this.bookmarkData,
    this.chapterList = const [],
  });
}
