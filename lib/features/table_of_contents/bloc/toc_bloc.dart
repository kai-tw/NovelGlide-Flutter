import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../data/loading_state_code.dart';

class TocCubit extends Cubit<TocState> {
  final PageStorageBucket bucket = PageStorageBucket();
  final ScrollController scrollController = ScrollController();
  BookData bookData;

  TocCubit(this.bookData) : super(const TocState());

  Future<void> refresh({BookData? newData}) async {
    bookData = newData ?? bookData;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      emit(TocState(
        code: LoadingStateCode.loaded,
        bookmarkData: BookmarkData.get(bookData.filePath),
      ));
    });
  }
}

class TocState extends Equatable {
  final LoadingStateCode code;
  final BookmarkData? bookmarkData;

  @override
  List<Object?> get props => [code, bookmarkData];

  const TocState({
    this.code = LoadingStateCode.initial,
    this.bookmarkData,
  });

  TocState copyWith({
    LoadingStateCode? code,
    BookmarkData? bookmarkData,
  }) {
    return TocState(
      code: code ?? this.code,
      bookmarkData: bookmarkData ?? this.bookmarkData,
    );
  }
}
