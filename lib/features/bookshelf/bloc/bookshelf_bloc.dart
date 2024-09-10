import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/book_data.dart';
import '../../../data/loading_state_code.dart';
import '../../../data/sort_order_code.dart';

class BookshelfCubit extends Cubit<BookshelfState> {
  BookshelfCubit() : super(const BookshelfState());

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  Future<void> refresh() async {
    final Box box = Hive.box(name: 'settings');
    SortOrderCode sortOrder =
        SortOrderCode.fromString(box.get('bookshelf.sortOrder'), defaultValue: SortOrderCode.name);
    bool isAscending = box.get('bookshelf.isAscending', defaultValue: true);
    box.close();

    List<BookData> list = await BookData.getDataList();

    _sortList(list, sortOrder, isAscending);

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

  void setListOrder({SortOrderCode? sortOrder, bool? isAscending}) {
    SortOrderCode order = sortOrder ?? state.sortOrder;
    bool ascending = isAscending ?? state.isAscending;

    final Box box = Hive.box(name: 'settings');
    box.put('bookshelf.sortOrder', order.toString());
    box.put('bookshelf.isAscending', ascending);
    box.close();

    _sortList(state.bookList, order, ascending);
    emit(state.copyWith(
      isAscending: ascending,
      sortOrder: order,
    ));
  }

  void _sortList(List<BookData> list, SortOrderCode sortOrder, bool isAscending) {
    switch (sortOrder) {
      case SortOrderCode.modifiedDate:
        list.sort((a, b) =>
            isAscending ? a.modifiedDate.compareTo(b.modifiedDate) : b.modifiedDate.compareTo(a.modifiedDate));
        break;

      default:
        list.sort((a, b) => isAscending ? compareNatural(a.name, b.name) : compareNatural(b.name, a.name));
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
  final SortOrderCode sortOrder;
  final List<BookData> bookList;
  final Set<BookData> selectedBooks;
  final bool isDragging;
  final bool isSelecting;
  final bool isAscending;

  @override
  List<Object?> get props => [code, sortOrder, bookList, selectedBooks, isDragging, isSelecting, isAscending];

  const BookshelfState({
    this.code = LoadingStateCode.initial,
    this.sortOrder = SortOrderCode.name,
    this.bookList = const [],
    this.selectedBooks = const {},
    this.isDragging = false,
    this.isSelecting = false,
    this.isAscending = true,
  });

  BookshelfState copyWith({
    LoadingStateCode? code,
    SortOrderCode? sortOrder,
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
