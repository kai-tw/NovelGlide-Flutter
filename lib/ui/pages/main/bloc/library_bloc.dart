import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';

enum LibraryBookListStateCode { normal, selecting, unload, loading, noBook }

class LibraryBookListCubit extends Cubit<LibraryBookListState> {
  LibraryBookListCubit() : super(const LibraryBookListState());

  /// Get the list of latest books.
  void refresh() async {
    LibraryBookListState initState = const LibraryBookListState(code: LibraryBookListStateCode.loading);
    emit(initState);
    List<String> list = await FileProcess.getLibraryBookList();
    LibraryBookListStateCode code = list.isEmpty ? LibraryBookListStateCode.noBook : LibraryBookListStateCode.normal;
    emit(initState.copyWith(code: code, bookList: list));
  }

  /// Add the book into the selected list.
  void addSelect(LibraryBookListState state, String name) {
    if (state.selectedBooks.contains(name)) {
      return;
    }
    Set<String> selectedSet = Set<String>.from(state.selectedBooks);
    selectedSet.add(name);
    emit(state.copyWith(code: LibraryBookListStateCode.selecting, selectedBooks: selectedSet));
  }

  /// Select all books except those the slide menu is open.
  void allSelect(LibraryBookListState state) {
    emit(state.copyWith(
      code: LibraryBookListStateCode.selecting,
      selectedBooks: state.bookList.toSet().difference(state.slidedBook),
    ));
  }

  /// Remove the book from the selected list.
  void removeSelect(LibraryBookListState state, String name) {
    if (!state.selectedBooks.contains(name)) {
      return;
    }
    Set<String> selectedSet = Set<String>.from(state.selectedBooks);
    selectedSet.remove(name);
    LibraryBookListStateCode stateCode =
        selectedSet.isNotEmpty ? LibraryBookListStateCode.selecting : LibraryBookListStateCode.normal;
    emit(state.copyWith(code: stateCode, selectedBooks: selectedSet));
  }

  /// Clear the selected list.
  void clearSelect(LibraryBookListState state) {
    emit(state.copyWith(code: LibraryBookListStateCode.normal, selectedBooks: <String>{}));
  }

  /// Add the book into the sliding set.
  void addSlide(LibraryBookListState state, String name) {
    if (state.slidedBook.contains(name)) {
      return;
    }

    // If the book is selected, remove it from the selection set.
    LibraryBookListStateCode code = state.code;
    Set<String> selectedSet = Set<String>.from(state.selectedBooks);
    if (state.selectedBooks.contains(name)) {
      selectedSet.remove(name);
      code = selectedSet.isEmpty ? LibraryBookListStateCode.normal : LibraryBookListStateCode.selecting;
    }

    // Add the book into the sliding set.
    Set<String> slideSet = Set<String>.from(state.slidedBook);
    slideSet.add(name);
    emit(state.copyWith(code: code, selectedBooks: selectedSet, slidedBook: slideSet));
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
    for (var item in state.selectedBooks) {
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
  final Set<String> selectedBooks;
  final Set<String> slidedBook;

  const LibraryBookListState({
    this.code = LibraryBookListStateCode.unload,
    this.bookList = const [],
    this.selectedBooks = const <String>{},
    this.slidedBook = const <String>{},
  });

  LibraryBookListState copyWith({
    LibraryBookListStateCode? code,
    List<String>? bookList,
    Set<String>? selectedBooks,
    Set<String>? slidedBook,
  }) {
    return LibraryBookListState(
      code: code ?? this.code,
      bookList: bookList ?? this.bookList,
      selectedBooks: selectedBooks ?? this.selectedBooks,
      slidedBook: slidedBook ?? this.slidedBook,
    );
  }

  @override
  List<Object?> get props => [code, bookList, selectedBooks, slidedBook];
}
