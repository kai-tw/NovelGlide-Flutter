import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../processor/book_processor.dart';

class BookshelfCubit extends Cubit<BookshelfState> {
  BookshelfCubit() : super(const BookshelfState());

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  Future<void> refresh() async {
    List<BookData> list = await BookProcessor.getDataList();
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

  Future<void> setSortOrder(BookshelfSortOrder sortOrder) async {
    List<BookData> list = await BookProcessor.getDataList();
    _sortBookList(list, sortOrder, state.isAscending);
    if (!isClosed) {
      emit(state.copyWith(sortOrder: sortOrder, bookList: list));
    }
  }

  Future<void> setAscending(bool isAscending) async {
    List<BookData> list = await BookProcessor.getDataList();
    _sortBookList(list, state.sortOrder, isAscending);
    if (!isClosed) {
      emit(state.copyWith(isAscending: isAscending, bookList: list));
    }
  }

  void _sortBookList(List<BookData> list, BookshelfSortOrder sortOrder, bool isAscending) {
    switch (sortOrder) {
      case BookshelfSortOrder.name:
        list.sort((a, b) => isAscending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
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

  void selectBook(String bookName) {
    emit(state.copyWith(selectedBooks: {...state.selectedBooks, bookName}));
  }

  void selectAllBooks() {
    emit(state.copyWith(
      selectedBooks: state.bookList.map((e) => e.name).toSet(),
    ));
  }

  void deselectBook(String bookName) {
    Set<String> newSet = Set<String>.from(state.selectedBooks);
    newSet.remove(bookName);

    emit(state.copyWith(selectedBooks: newSet));
  }

  void deselectAllBooks() {
    emit(state.copyWith(selectedBooks: const {}));
  }

  Future<bool> deleteSelectedBooks() async {
    for (String bookName in state.selectedBooks) {
      BookProcessor.delete(bookName);
    }
    await refresh();
    return true;
  }
}

class BookshelfState extends Equatable {
  final BookshelfStateCode code;
  final BookshelfSortOrder sortOrder;
  final List<BookData> bookList;
  final Set<String> selectedBooks;
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
    Set<String>? selectedBooks,
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
