import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../../processor/bookmark_processor.dart';

class BookmarkManagerCubit extends Cubit<BookmarkManagerState> {
  BookmarkManagerCubit() : super(const BookmarkManagerState());

  void refresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final List<BookmarkData> bookmarkList = BookmarkProcessor.getList();
      emit(BookmarkManagerState(
        code: bookmarkList.isEmpty ? BookmarkManagerStateCode.empty : BookmarkManagerStateCode.normal,
        bookmarkList: bookmarkList,
      ));
    });
  }

  void selectBookmark(String bookName) {
    emit(state.copyWith(
      selectedBookmarks: {
        ...state.selectedBookmarks,
        bookName,
      },
    ));
  }

  void deselectBookmark(String bookName) {
    Set<String> newSet = Set<String>.from(state.selectedBookmarks);
    newSet.remove(bookName);

    emit(state.copyWith(
      selectedBookmarks: newSet,
    ));
  }

  Future<bool> deleteSelectedBookmarks() async {
    for (String bookName in state.selectedBookmarks) {
      BookmarkData.fromBookName(bookName).clear();
    }
    refresh();
    return true;
  }
}

class BookmarkManagerState extends Equatable {
  final BookmarkManagerStateCode code;
  final List<BookmarkData> bookmarkList;
  final Set<String> selectedBookmarks;

  @override
  List<Object?> get props => [
        code,
        bookmarkList,
        selectedBookmarks,
      ];

  const BookmarkManagerState({
    this.code = BookmarkManagerStateCode.loading,
    this.bookmarkList = const [],
    this.selectedBookmarks = const {},
  });

  BookmarkManagerState copyWith({
    BookmarkManagerStateCode? code,
    List<BookmarkData>? bookmarkList,
    Set<String>? selectedBookmarks,
  }) {
    return BookmarkManagerState(
      code: code ?? this.code,
      bookmarkList: bookmarkList ?? this.bookmarkList,
      selectedBookmarks: selectedBookmarks ?? this.selectedBookmarks,
    );
  }
}

enum BookmarkManagerStateCode { normal, loading, empty }
