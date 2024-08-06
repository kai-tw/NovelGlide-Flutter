import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../../processor/bookmark_processor.dart';

enum BookmarkListStateCode { normal, loading, empty }

class BookmarkListCubit extends Cubit<BookmarkListState> {
  BookmarkListCubit() : super(const BookmarkListState());

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  Future<void> refresh() async {
    final List<BookmarkData> bookmarkList = await BookmarkProcessor.getList();
    bookmarkList.sort((a, b) => b.savedTime.compareTo(a.savedTime));

    if (!isClosed) {
      emit(BookmarkListState(
        code: bookmarkList.isEmpty ? BookmarkListStateCode.empty : BookmarkListStateCode.normal,
        bookmarkList: bookmarkList,
      ));
    }
  }

  void setDragging(bool isDragging) {
    emit(state.copyWith(isDragging: isDragging));
  }

  void setSelecting(bool isSelecting) {
    emit(state.copyWith(isSelecting: isSelecting, selectedBookmarks: const {}));
  }

  void selectBookmark(String bookName) {
    emit(state.copyWith(
      selectedBookmarks: {
        ...state.selectedBookmarks,
        bookName,
      },
    ));
  }

  void selectAllBookmarks() {
    emit(state.copyWith(
      selectedBookmarks: state.bookmarkList.map((e) => e.bookName).toSet(),
    ));
  }

  void deselectBookmark(String bookName) {
    Set<String> newSet = Set<String>.from(state.selectedBookmarks);
    newSet.remove(bookName);

    emit(state.copyWith(
      selectedBookmarks: newSet,
    ));
  }

  void deselectAllBookmarks() {
    emit(state.copyWith(
      selectedBookmarks: const {},
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

class BookmarkListState extends Equatable {
  final BookmarkListStateCode code;
  final List<BookmarkData> bookmarkList;
  final Set<String> selectedBookmarks;
  final bool isDragging;
  final bool isSelecting;

  @override
  List<Object?> get props => [code, bookmarkList, selectedBookmarks, isDragging, isSelecting];

  const BookmarkListState({
    this.code = BookmarkListStateCode.loading,
    this.bookmarkList = const [],
    this.selectedBookmarks = const {},
    this.isDragging = false,
    this.isSelecting = false,
  });

  BookmarkListState copyWith({
    BookmarkListStateCode? code,
    List<BookmarkData>? bookmarkList,
    Set<String>? selectedBookmarks,
    bool? isDragging,
    bool? isSelecting,
  }) {
    return BookmarkListState(
      code: code ?? this.code,
      bookmarkList: bookmarkList ?? this.bookmarkList,
      selectedBookmarks: selectedBookmarks ?? this.selectedBookmarks,
      isDragging: isDragging ?? this.isDragging,
      isSelecting: isSelecting ?? this.isSelecting,
    );
  }
}
