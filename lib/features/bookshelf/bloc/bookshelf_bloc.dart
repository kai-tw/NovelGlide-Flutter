import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';

class BookshelfCubit extends Cubit<BookshelfState> {
  List<BookData> _bookList = [];

  BookshelfCubit() : super(const BookshelfState());

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  Future<void> refresh() async {
    List<BookData> list = _bookList = await BookData.getDataList();
    BookshelfStateCode code = list.isEmpty ? BookshelfStateCode.empty : BookshelfStateCode.normal;
    _sortBookList(list, state.sortOrder, state.isAscending);
    if (!isClosed) {
      emit(BookshelfState(
        code: code,
        sortOrder: state.sortOrder,
        bookList: list,
        isSelecting: state.isSelecting,
        isAscending: state.isAscending,
      ));
    }
  }

  void setSortOrder(BookshelfSortOrder sortOrder) {
    _sortBookList(_bookList, sortOrder, state.isAscending);
    emit(state.copyWith(sortOrder: sortOrder, bookList: _bookList));
  }

  void setAscending(bool isAscending) {
    _sortBookList(_bookList, state.sortOrder, isAscending);
    emit(state.copyWith(isAscending: isAscending, bookList: _bookList));
  }

  void _sortBookList(List<BookData> list, BookshelfSortOrder sortOrder, bool isAscending) {
    switch (sortOrder) {
      case BookshelfSortOrder.name:
        list.sort((a, b) => isAscending ? compareNatural(a.name, b.name) : compareNatural(b.name, a.name));
        break;
      case BookshelfSortOrder.modifiedDate:
        list.sort((a, b) =>
            isAscending ? a.modifiedDate.compareTo(b.modifiedDate) : b.modifiedDate.compareTo(a.modifiedDate));
        break;
    }
  }

  void setDragging(bool isDragging) {
    emit(state.copyWith(isDragging: isDragging));
  }

  void setSelecting(bool isSelecting) {
    emit(state.copyWith(isSelecting: isSelecting, selectedBooks: const {}));
  }

  void selectBook(BookData bookData) {
    emit(state.copyWith(selectedBooks: {...state.selectedBooks, bookData}));
  }

  void selectAllBooks() {
    emit(state.copyWith(
      selectedBooks: state.bookList.toSet(),
    ));
  }

  void deselectBook(BookData bookData) {
    Set<BookData> newSet = Set<BookData>.from(state.selectedBooks);
    newSet.remove(bookData);

    emit(state.copyWith(selectedBooks: newSet));
  }

  void deselectAllBooks() {
    emit(state.copyWith(selectedBooks: const {}));
  }

  Future<bool> deleteSelectedBooks() async {
    for (BookData bookData in state.selectedBooks) {
      bookData.delete();
    }
    await refresh();
    return true;
  }
}

class BookshelfState extends Equatable {
  final BookshelfStateCode code;
  final BookshelfSortOrder sortOrder;
  final List<BookData> bookList;
  final Set<BookData> selectedBooks;
  final bool isDragging;
  final bool isSelecting;
  final bool isAscending;

  @override
  List<Object?> get props => [code, sortOrder, bookList, selectedBooks, isDragging, isSelecting, isAscending];

  const BookshelfState({
    this.code = BookshelfStateCode.loading,
    this.sortOrder = BookshelfSortOrder.name,
    this.bookList = const [],
    this.selectedBooks = const {},
    this.isDragging = false,
    this.isSelecting = false,
    this.isAscending = true,
  });

  BookshelfState copyWith({
    BookshelfStateCode? code,
    BookshelfSortOrder? sortOrder,
    List<BookData>? bookList,
    Set<BookData>? selectedBooks,
    bool? isDragging,
    bool? isSelecting,
    bool? isAscending,
  }) {
    return BookshelfState(
      code: code ?? this.code,
      sortOrder: sortOrder ?? this.sortOrder,
      bookList: bookList ?? this.bookList,
      selectedBooks: selectedBooks ?? this.selectedBooks,
      isDragging: isDragging ?? this.isDragging,
      isSelecting: isSelecting ?? this.isSelecting,
      isAscending: isAscending ?? this.isAscending,
    );
  }
}

enum BookshelfStateCode { normal, empty, loading }

enum BookshelfSortOrder { name, modifiedDate }
