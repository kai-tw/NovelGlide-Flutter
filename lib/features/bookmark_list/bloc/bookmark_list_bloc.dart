import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../../processor/bookmark_processor.dart';

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
        sortOrder: state.sortOrder,
        bookmarkList: bookmarkList,
        isSelecting: state.isSelecting,
        isAscending: state.isAscending,
      ));
    }
  }

  Future<void> setSortOrder(BookmarkListSortOrder sortOrder) async {
    List<BookmarkData> list = await BookmarkProcessor.getList();
    _sortBookmarkList(list, sortOrder, state.isAscending);
    if (!isClosed) {
      emit(state.copyWith(sortOrder: sortOrder, bookmarkList: list));
    }
  }

  void _sortBookmarkList(List<BookmarkData> list, BookmarkListSortOrder sortOrder, bool isAscending) {
    switch (sortOrder) {
      case BookmarkListSortOrder.name:
        list.sort(
            (a, b) => isAscending ? compareNatural(a.bookName, b.bookName) : compareNatural(b.bookName, a.bookName));
        break;
      case BookmarkListSortOrder.savedTime:
        list.sort((a, b) => isAscending ? a.savedTime.compareTo(b.savedTime) : b.savedTime.compareTo(a.savedTime));
        break;
    }
  }

  Future<void> setAscending(bool isAscending) async {
    List<BookmarkData> list = await BookmarkProcessor.getList();
    _sortBookmarkList(list, state.sortOrder, isAscending);
    if (!isClosed) {
      emit(state.copyWith(isAscending: isAscending, bookmarkList: list));
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
      BookmarkProcessor.delete(bookName);
    }
    refresh();
    return true;
  }
}

class BookmarkListState extends Equatable {
  final BookmarkListStateCode code;
  final BookmarkListSortOrder sortOrder;
  final List<BookmarkData> bookmarkList;
  final Set<String> selectedBookmarks;
  final bool isDragging;
  final bool isSelecting;
  final bool isAscending;

  @override
  List<Object?> get props => [code, sortOrder, bookmarkList, selectedBookmarks, isDragging, isSelecting, isAscending];

  const BookmarkListState({
    this.code = BookmarkListStateCode.loading,
    this.sortOrder = BookmarkListSortOrder.savedTime,
    this.bookmarkList = const [],
    this.selectedBookmarks = const {},
    this.isDragging = false,
    this.isSelecting = false,
    this.isAscending = false,
  });

  BookmarkListState copyWith({
    BookmarkListStateCode? code,
    BookmarkListSortOrder? sortOrder,
    List<BookmarkData>? bookmarkList,
    Set<String>? selectedBookmarks,
    bool? isDragging,
    bool? isSelecting,
    bool? isAscending,
  }) {
    return BookmarkListState(
      code: code ?? this.code,
      sortOrder: sortOrder ?? this.sortOrder,
      bookmarkList: bookmarkList ?? this.bookmarkList,
      selectedBookmarks: selectedBookmarks ?? this.selectedBookmarks,
      isDragging: isDragging ?? this.isDragging,
      isSelecting: isSelecting ?? this.isSelecting,
      isAscending: isAscending ?? this.isAscending,
    );
  }
}

enum BookmarkListStateCode { normal, loading, empty }

enum BookmarkListSortOrder { name, savedTime }
