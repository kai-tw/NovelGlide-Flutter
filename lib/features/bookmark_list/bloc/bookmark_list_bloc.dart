import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../../processor/bookmark_processor.dart';

enum BookmarkListStateCode { normal, loading, empty }

class BookmarkListCubit extends Cubit<BookmarkListState> {
  BookmarkListCubit() : super(const BookmarkListState());

  void refresh() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final List<BookmarkData> bookmarkList = await BookmarkProcessor.getList();
      bookmarkList.sort((a, b) => b.savedTime.compareTo(a.savedTime));

      emit(BookmarkListState(
        code: bookmarkList.isEmpty ? BookmarkListStateCode.empty : BookmarkListStateCode.normal,
        bookmarkList: bookmarkList,
      ));
    });
  }
}

class BookmarkListState extends Equatable {
  final BookmarkListStateCode code;
  final List<BookmarkData> bookmarkList;

  @override
  List<Object?> get props => [code, bookmarkList];

  const BookmarkListState({
    this.code = BookmarkListStateCode.loading,
    this.bookmarkList = const [],
  });

  BookmarkListState copyWith({
    BookmarkListStateCode? code,
    List<BookmarkData>? bookmarkList,
  }) {
    return BookmarkListState(
      code: code ?? this.code,
      bookmarkList: bookmarkList ?? this.bookmarkList,
    );
  }
}
