import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/book_data.dart';
import '../../../data/preference_keys.dart';
import '../../../toolbox/file_path.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/sort_order_code.dart';
import '../../../toolbox/mime_resolver.dart';

class BookshelfCubit extends Cubit<BookshelfState> {
  bool isInitialized = false;

  BookshelfCubit() : super(const BookshelfState());

  void init() {
    if (isInitialized) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
    isInitialized = true;
  }

  Future<void> refresh() async {
    emit(const BookshelfState(code: LoadingStateCode.loading));

    // Load the sorting preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    SortOrderCode sortOrder = SortOrderCode.fromString(prefs.getString(PreferenceKeys.bookshelf.sortOrder) ?? 'name');
    bool isAscending = prefs.getBool(PreferenceKeys.bookshelf.isAscending) ?? true;

    final Directory folder = Directory(await FilePath.libraryRoot);
    final Iterable<File> fileList = folder
        .listSync()
        .whereType<File>()
        .where((e) => MimeResolver.lookupAll(e) == 'application/epub+zip');
    List<BookData> list = [];

    for (File epubFile in fileList) {
      if (state.bookList.any((element) => element.filePath == epubFile.path)) {
        // Old book! Reference it.
        list.add(state.bookList.firstWhere((element) => element.filePath == epubFile.path));
      } else {
        // New book! Read it.
        list.add(BookData.fromEpubBook(epubFile.path, await BookData.loadEpubBook(epubFile.path)));
      }
    }

    list.sort(BookData.sortCompare(sortOrder, isAscending));

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

  Future<void> setListOrder({SortOrderCode? sortOrder, bool? isAscending}) async {
    SortOrderCode order = sortOrder ?? state.sortOrder;
    bool ascending = isAscending ?? state.isAscending;

    // Save the sorting preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceKeys.bookshelf.sortOrder, order.toString());
    prefs.setBool(PreferenceKeys.bookshelf.isAscending, ascending);

    state.bookList.sort(BookData.sortCompare(order, ascending));
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
    List<BookData> newList = List<BookData>.from(state.bookList);
    for (BookData bookData in state.selectedBooks) {
      await bookData.delete();
      newList.remove(bookData);
    }
    emit(state.copyWith(bookList: newList));
    return true;
  }

  void deleteBook(BookData bookData) async {
    await bookData.delete();

    // Update the book list
    List<BookData> newList = List<BookData>.from(state.bookList);
    newList.remove(bookData);
    emit(state.copyWith(bookList: newList));
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
