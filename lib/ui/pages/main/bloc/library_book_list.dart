import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';

enum LibraryBookListAppBarState { normal, selecting }

class LibraryBookListCubit extends Cubit<LibraryBookListState> {
  LibraryBookListCubit() : super(const LibraryBookListState(false, false, LibraryBookListAppBarState.normal, [], <String>{}));

  /// Get the list of latest books.
  void refresh() async {
    List<String> list = await FileProcess.getLibraryBookList();
    emit(LibraryBookListState(true, false, LibraryBookListAppBarState.normal, list, const <String>{}));
  }

  /// Add the book into the selected list.
  void addSelect(LibraryBookListState state, String name) {
    List<String> bookList = List<String>.from(state.bookList);
    Set<String> selectedBook = Set<String>.from(state.selectedBook);
    selectedBook.add(name);
    emit(LibraryBookListState(true, true, LibraryBookListAppBarState.selecting, bookList, selectedBook));
  }

  /// Remove the book from the selected list.
  void removeSelect(LibraryBookListState state, String name) {
    List<String> bookList = List<String>.from(state.bookList);
    Set<String> selectedBook = Set<String>.from(state.selectedBook);
    selectedBook.remove(name);
    emit(LibraryBookListState(
        true,
        selectedBook.isNotEmpty,
        selectedBook.isNotEmpty ? LibraryBookListAppBarState.selecting : LibraryBookListAppBarState.normal,
        bookList,
        selectedBook));
  }

  /// Clear the selected list.
  void clearSelect(LibraryBookListState state) {
    List<String> bookList = List<String>.from(state.bookList);
    emit(LibraryBookListState(true, false, LibraryBookListAppBarState.normal, bookList, const <String>{}));
  }

  /// Delete all books selected by the user.
  void deleteSelectBook(LibraryBookListState state) {
    for (var item in state.selectedBook) {
      FileProcess.deleteBook(item);
    }
    refresh();
  }
}

/// Store the state of the book list of the library in the main page.
/// @param  isLoaded      Determine if the book list is fetched.
///         isSelecting   Determine if the user is selecting some books.
///         bookList      The list stores the names of all books.
///         selectedBook  The set stores the books selected by the user.
class LibraryBookListState extends Equatable {
  final bool isLoaded;
  final bool isSelecting;
  final LibraryBookListAppBarState appBarState;
  final List<String> bookList;
  final Set<String> selectedBook;

  const LibraryBookListState(this.isLoaded, this.isSelecting, this.appBarState, this.bookList, this.selectedBook);

  LibraryBookListState copyWith() {
    return LibraryBookListState(isLoaded, isSelecting, appBarState, bookList, selectedBook);
  }

  @override
  List<Object?> get props => [isLoaded, isSelecting, appBarState, bookList, selectedBook];
}
