import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';

enum LibraryBookListStateCode { normal, selecting, unLoad, loading, noBook }

class LibraryBookListCubit extends Cubit<LibraryBookListState> {
  LibraryBookListCubit()
      : super(const LibraryBookListState(LibraryBookListStateCode.unLoad, [], <String>{}, <String>{}));

  /// Get the list of latest books.
  void refresh() async {
    LibraryBookListState initState =
        const LibraryBookListState(LibraryBookListStateCode.loading, [], <String>{}, <String>{});
    emit(initState);
    List<String> list = await FileProcess.getLibraryBookList();
    LibraryBookListStateCode code = list.isEmpty ? LibraryBookListStateCode.noBook : LibraryBookListStateCode.normal;
    emit(initState.copyWith(code: code, bookList: list));
  }

  /// Add the book into the selected list.
  void addSelect(LibraryBookListState state, String name) {
    if (state.selectedBook.contains(name)) {
      return;
    }
    Set<String> selectedSet = Set<String>.from(state.selectedBook);
    selectedSet.add(name);
    emit(state.copyWith(code: LibraryBookListStateCode.selecting, selectedBook: selectedSet));
  }

  /// Select all books except those the slide menu is open.
  void allSelect(LibraryBookListState state) {
    emit(state.copyWith(
      code: LibraryBookListStateCode.selecting,
      selectedBook: state.bookList.toSet().difference(state.slidedBook),
    ));
  }

  /// Remove the book from the selected list.
  void removeSelect(LibraryBookListState state, String name) {
    if (!state.selectedBook.contains(name)) {
      return;
    }
    Set<String> selectedSet = Set<String>.from(state.selectedBook);
    selectedSet.remove(name);
    LibraryBookListStateCode stateCode =
        selectedSet.isNotEmpty ? LibraryBookListStateCode.selecting : LibraryBookListStateCode.normal;
    emit(state.copyWith(code: stateCode, selectedBook: selectedSet));
  }

  /// Clear the selected list.
  void clearSelect(LibraryBookListState state) {
    emit(state.copyWith(code: LibraryBookListStateCode.normal, selectedBook: <String>{}));
  }

  /// Add the book into the sliding set.
  void addSlide(LibraryBookListState state, String name) {
    if (state.slidedBook.contains(name)) {
      return;
    }
    Set<String> slideSet = Set<String>.from(state.slidedBook);
    slideSet.add(name);
    emit(state.copyWith(slidedBook: slideSet));
  }

  /// Remove the book from the sliding set.
  void removeSlide(LibraryBookListState state, String name) {
    if (!state.slidedBook.contains(name)) {
      return;
    }
    Set<String> slideSet = Set<String>.from(state.slidedBook);
    slideSet.remove(name);
    emit(state.copyWith(slidedBook: slideSet));
  }

  /// Delete all books selected by the user.
  void deleteSelectBook(LibraryBookListState state) {
    for (var item in state.selectedBook) {
      FileProcess.deleteBook(item);
    }
    refresh();
  }

  /// Delete the book by the user.
  void deleteBook(LibraryBookListState state, String bookName) {
    FileProcess.deleteBook(bookName);
    refresh();
  }
}

/// Store the state of the book list of the library in the main page.
/// @param  isLoaded      Determine if the book list is loaded.
///         isSelecting   Determine if the user is selecting some books.
///         bookList      The list stores the names of all books.
///         selectedBook  The set stores the books selected by the user.
///         slidedBook    The set stores the books whose sliding menu is open.
class LibraryBookListState extends Equatable {
  final LibraryBookListStateCode code;
  final List<String> bookList;
  final Set<String> selectedBook;
  final Set<String> slidedBook;

  const LibraryBookListState(this.code, this.bookList, this.selectedBook, this.slidedBook);

  LibraryBookListState copyWith({
    LibraryBookListStateCode? code,
    List<String>? bookList,
    Set<String>? selectedBook,
    Set<String>? slidedBook,
  }) {
    return LibraryBookListState(
      code ?? this.code,
      bookList ?? this.bookList,
      selectedBook ?? this.selectedBook,
      slidedBook ?? this.slidedBook,
    );
  }

  @override
  List<Object?> get props => [code, bookList, selectedBook, slidedBook];
}
