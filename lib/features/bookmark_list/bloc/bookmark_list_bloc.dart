import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/loading_state_code.dart';

class BookmarkListCubit extends Cubit<BookmarkListState> {
  BookmarkListCubit() : super(const BookmarkListState());

  void refresh() async {
    final List<BookmarkData> bookmarkList = await BookmarkData.getList();
    bookmarkList.sort((a, b) => b.savedTime.compareTo(a.savedTime));

    if (!isClosed) {
      emit(BookmarkListState(
        code: LoadingStateCode.loaded,
        sortOrder: state.sortOrder,
        bookmarkList: bookmarkList,
        isAscending: state.isAscending,
      ));
    }
  }

  void unfocused() {
    emit(state.copyWith(isDragging: false, isSelecting: false));
  }

  void setSortOrder(BookmarkListSortOrder sortOrder) async {
    List<BookmarkData> list = await BookmarkData.getList();
    _sortBookmarkList(list, sortOrder, state.isAscending);
    if (!isClosed) {
      emit(state.copyWith(sortOrder: sortOrder, bookmarkList: list));
    }
  }

  void _sortBookmarkList(List<BookmarkData> list, BookmarkListSortOrder sortOrder, bool isAscending) {
    switch (sortOrder) {
      case BookmarkListSortOrder.name:
        list.sort(
            (a, b) => isAscending ? compareNatural(a.bookPath, b.bookPath) : compareNatural(b.bookPath, a.bookPath));
        break;
      case BookmarkListSortOrder.savedTime:
        list.sort((a, b) => isAscending ? a.savedTime.compareTo(b.savedTime) : b.savedTime.compareTo(a.savedTime));
        break;
    }
  }

  void setAscending(bool isAscending) async {
    List<BookmarkData> list = await BookmarkData.getList();
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

  void selectBookmark(BookmarkData data) {
    emit(state.copyWith(
      selectedBookmarks: {
        ...state.selectedBookmarks,
        data,
      },
    ));
  }

  void selectAllBookmarks() {
    emit(state.copyWith(
      selectedBookmarks: state.bookmarkList.toSet(),
    ));
  }

  void deselectBookmark(BookmarkData data) {
    Set<BookmarkData> newSet = Set<BookmarkData>.from(state.selectedBookmarks);
    newSet.remove(data);

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
    for (BookmarkData data in state.selectedBookmarks) {
      data.delete();
    }
    refresh();
    return true;
  }
}

class BookmarkListState extends Equatable {
  final LoadingStateCode code;
  final BookmarkListSortOrder sortOrder;
  final List<BookmarkData> bookmarkList;
  final Set<BookmarkData> selectedBookmarks;
  final bool isDragging;
  final bool isSelecting;
  final bool isAscending;

  @override
  List<Object?> get props => [code, sortOrder, bookmarkList, selectedBookmarks, isDragging, isSelecting, isAscending];

  const BookmarkListState({
    this.code = LoadingStateCode.initial,
    this.sortOrder = BookmarkListSortOrder.savedTime,
    this.bookmarkList = const [],
    this.selectedBookmarks = const {},
    this.isDragging = false,
    this.isSelecting = false,
    this.isAscending = false,
  });

  BookmarkListState copyWith({
    LoadingStateCode? code,
    BookmarkListSortOrder? sortOrder,
    List<BookmarkData>? bookmarkList,
    Set<BookmarkData>? selectedBookmarks,
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

enum BookmarkListSortOrder { name, savedTime }
