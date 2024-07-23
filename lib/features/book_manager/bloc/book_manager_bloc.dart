import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../processor/book_processor.dart';

class BookManagerCubit extends Cubit<BookManagerState> {
  BookManagerCubit() : super(const BookManagerState());

  void refresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final List<BookData> bookList = await BookProcessor.getDataList();
      if (!isClosed) {
        emit(BookManagerState(
          code: bookList.isEmpty ? BookManagerStateCode.empty : BookManagerStateCode.normal,
          bookList: bookList,
        ));
      }
    });
  }

  void selectBook(String bookName) {
    emit(state.copyWith(
      selectedBooks: {
        ...state.selectedBooks,
        bookName,
      },
    ));
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
    refresh();
    return true;
  }
}

class BookManagerState extends Equatable {
  final BookManagerStateCode code;
  final List<BookData> bookList;
  final Set<String> selectedBooks;

  @override
  List<Object?> get props => [
        code,
        bookList,
        selectedBooks,
      ];

  const BookManagerState({
    this.code = BookManagerStateCode.loading,
    this.bookList = const [],
    this.selectedBooks = const {},
  });

  BookManagerState copyWith({
    BookManagerStateCode? code,
    List<BookData>? bookList,
    Set<String>? selectedBooks,
  }) {
    return BookManagerState(
      code: code ?? this.code,
      bookList: bookList ?? this.bookList,
      selectedBooks: selectedBooks ?? this.selectedBooks,
    );
  }
}

enum BookManagerStateCode { normal, loading, empty }