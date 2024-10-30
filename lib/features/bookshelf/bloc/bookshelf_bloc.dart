import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data_model/book_data.dart';
import '../../../data_model/preference_keys.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/sort_order_code.dart';
import '../../../repository/book_repository.dart';
import '../../../utils/book_utils.dart';
import '../../../utils/epub_utils.dart';
import '../../../utils/file_path.dart';
import '../../../utils/mime_resolver.dart';

class BookshelfCubit extends Cubit<BookshelfState> {
  final String _sortOrderKey = PreferenceKeys.bookshelf.sortOrder;
  final String _isAscendingKey = PreferenceKeys.bookshelf.isAscending;

  factory BookshelfCubit() {
    final cubit = BookshelfCubit._internal(const BookshelfState());
    WidgetsBinding.instance.addPostFrameCallback((_) => cubit.refresh());
    return cubit;
  }

  BookshelfCubit._internal(super.initialState);

  Future<void> refresh() async {
    emit(const BookshelfState(code: LoadingStateCode.loading));

    // Load the sorting preferences.
    final prefs = await SharedPreferences.getInstance();
    final sortOrder = SortOrderCode.fromString(prefs.getString(_sortOrderKey));
    final isAscending = prefs.getBool(_isAscendingKey) ?? true;

    final folder = Directory(FilePath.libraryRoot);
    final fileList = folder
        .listSync()
        .whereType<File>()
        .where((e) => MimeResolver.lookupAll(e) == 'application/epub+zip');
    List<BookData> list = [];

    // Only read the books that are not read yet.
    for (File epubFile in fileList) {
      final target =
          state.bookList.firstWhereOrNull((e) => e.filePath == epubFile.path) ??
              BookData.fromEpubBook(
                  epubFile.path, await EpubUtils.loadEpubBook(epubFile.path));
      list.add(target);
    }

    list.sort(BookUtils.sortCompare(sortOrder, isAscending));

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

  Future<void> setListOrder({
    SortOrderCode? sortOrder,
    bool? isAscending,
  }) async {
    final order = sortOrder ?? state.sortOrder;
    final ascending = isAscending ?? state.isAscending;

    // Save the sorting preferences.
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_sortOrderKey, order.toString());
    prefs.setBool(_isAscendingKey, ascending);

    state.bookList.sort(BookUtils.sortCompare(order, ascending));
    emit(state.copyWith(
      isAscending: ascending,
      sortOrder: order,
    ));
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
    emit(state.copyWith(selectedBooks: state.bookList.toSet()));
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
    List<BookData> newList = List<BookData>.from(state.bookList);
    for (BookData bookData in state.selectedBooks) {
      await BookRepository.delete(bookData.filePath);
      newList.remove(bookData);
    }
    emit(state.copyWith(bookList: newList));
    return true;
  }

  Future<bool> deleteBook(BookData bookData) async {
    final isSuccess = await BookRepository.delete(bookData.filePath);

    // Update the book list
    List<BookData> newList = List<BookData>.from(state.bookList);
    newList.remove(bookData);
    emit(state.copyWith(bookList: newList));
    return isSuccess;
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
  List<Object?> get props => [
        code,
        sortOrder,
        bookList,
        selectedBooks,
        isDragging,
        isSelecting,
        isAscending
      ];

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
