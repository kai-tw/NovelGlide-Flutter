import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/book_data.dart';
import '../../../data/loading_state_code.dart';

class BookshelfCubit extends Cubit<BookshelfState> {
  BookshelfCubit() : super(const BookshelfState());

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  Future<void> refresh() async {
    final Box box = Hive.box(name: 'settings');
    BookshelfSortOrder sortOrder =
        BookshelfSortOrder.fromString(box.get('bookshelf.sortOrder'), defaultValue: BookshelfSortOrder.name);
    bool isAscending = box.get('bookshelf.isAscending', defaultValue: true);
    box.close();

    List<BookData> list = await BookData.getDataList();

    _sortBookList(list, sortOrder, isAscending);

    if (!isClosed) {
      emit(BookshelfState(
        code: LoadingStateCode.loaded,
        sortOrder: sortOrder,
        bookList: list,
        isAscending: isAscending,
      ));
    }
  }

  void unfocused() {
    emit(state.copyWith(isDragging: false, isSelecting: false));
  }

  void setListOrder({BookshelfSortOrder? sortOrder, bool? isAscending}) {
    BookshelfSortOrder order = sortOrder ?? state.sortOrder;
    bool ascending = isAscending ?? state.isAscending;

    final Box box = Hive.box(name: 'settings');
    box.put('bookshelf.sortOrder', order.toString());
    box.put('bookshelf.isAscending', ascending);
    box.close();

    _sortBookList(state.bookList, order, ascending);
    emit(state.copyWith(
      isAscending: ascending,
      sortOrder: order,
    ));
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
  final LoadingStateCode code;
  final BookshelfSortOrder sortOrder;
  final List<BookData> bookList;
  final Set<BookData> selectedBooks;
  final bool isDragging;
  final bool isSelecting;
  final bool isAscending;

  @override
  List<Object?> get props => [code, sortOrder, bookList, selectedBooks, isDragging, isSelecting, isAscending];

  const BookshelfState({
    this.code = LoadingStateCode.initial,
    this.sortOrder = BookshelfSortOrder.name,
    this.bookList = const [],
    this.selectedBooks = const {},
    this.isDragging = false,
    this.isSelecting = false,
    this.isAscending = true,
  });

  BookshelfState copyWith({
    LoadingStateCode? code,
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

enum BookshelfSortOrder {
  name,
  modifiedDate;

  static BookshelfSortOrder fromString(String? value, {BookshelfSortOrder defaultValue = BookshelfSortOrder.name}) {
    if (value == null) {
      return defaultValue;
    }
    return BookshelfSortOrder.values.firstWhere((element) => element.toString() == value);
  }
}
