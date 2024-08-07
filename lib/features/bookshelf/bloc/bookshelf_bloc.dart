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
    if (!isClosed) {
      emit(BookshelfState(
        code: code,
        bookList: list,
        isSelecting: state.isSelecting,
      ));
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

    emit(state.copyWith(
      selectedBooks: newSet,
    ));
  }

  void deselectAllBooks() {
    emit(state.copyWith(
      selectedBooks: const {},
    ));
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
  final List<BookData> bookList;
  final Set<String> selectedBooks;
  final bool isDragging;
  final bool isSelecting;

  @override
  List<Object?> get props => [code, bookList, selectedBooks, isDragging, isSelecting];

  const BookshelfState({
    this.code = BookshelfStateCode.loading,
    this.bookList = const [],
    this.selectedBooks = const {},
    this.isDragging = false,
    this.isSelecting = false,
  });

  BookshelfState copyWith({
    BookshelfStateCode? code,
    List<BookData>? bookList,
    Set<String>? selectedBooks,
    bool? isDragging,
    bool? isSelecting,
  }) {
    return BookshelfState(
      code: code ?? this.code,
      bookList: bookList ?? this.bookList,
      selectedBooks: selectedBooks ?? this.selectedBooks,
      isDragging: isDragging ?? this.isDragging,
      isSelecting: isSelecting ?? this.isSelecting,
    );
  }
}

enum BookshelfStateCode { normal, empty, loading }
