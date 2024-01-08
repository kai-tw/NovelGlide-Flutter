import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';

enum LibraryBookListStateCode { normal, selecting, unLoad, loading }

class LibraryBookListCubit extends Cubit<LibraryBookListState> {
  LibraryBookListCubit()
      : super(const LibraryBookListState(LibraryBookListStateCode.unLoad, [], <String>{}));

  /// Get the list of latest books.
  void refresh() async {
    emit(const LibraryBookListState(LibraryBookListStateCode.loading, [], <String>{}));
    List<String> list = await FileProcess.getLibraryBookList();
    emit(LibraryBookListState(LibraryBookListStateCode.normal, list, const <String>{}));
  }

  /// Add the book into the selected list.
  void addSelect(LibraryBookListState state, String name) {
    if (state.selectedBook.contains(name)) {
      return;
    }
    Set<String> selectedBook = Set<String>.from(state.selectedBook);
    selectedBook.add(name);
    emit(LibraryBookListState(LibraryBookListStateCode.selecting, state.bookList, selectedBook));
  }

  void allSelect(LibraryBookListState state) {
    emit(
        LibraryBookListState(LibraryBookListStateCode.selecting, state.bookList, state.bookList.toSet()));
  }

  /// Remove the book from the selected list.
  void removeSelect(LibraryBookListState state, String name) {
    if (!state.selectedBook.contains(name)) {
      return;
    }
    Set<String> selectedBook = Set<String>.from(state.selectedBook);
    selectedBook.remove(name);
    LibraryBookListStateCode stateCode =
        selectedBook.isNotEmpty ? LibraryBookListStateCode.selecting : LibraryBookListStateCode.normal;
    emit(LibraryBookListState(stateCode, state.bookList, selectedBook));
  }

  /// Clear the selected list.
  void clearSelect(LibraryBookListState state) {
    emit(LibraryBookListState(LibraryBookListStateCode.normal, state.bookList, const <String>{}));
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
/// @param  isLoaded      Determine if the book list is fetched.
///         isSelecting   Determine if the user is selecting some books.
///         bookList      The list stores the names of all books.
///         selectedBook  The set stores the books selected by the user.
class LibraryBookListState extends Equatable {
  final LibraryBookListStateCode code;
  final List<String> bookList;
  final Set<String> selectedBook;

  const LibraryBookListState(this.code, this.bookList, this.selectedBook);

  LibraryBookListState copyWith() {
    return LibraryBookListState(code, bookList, selectedBook);
  }

  @override
  List<Object?> get props => [code, bookList, selectedBook];
}
