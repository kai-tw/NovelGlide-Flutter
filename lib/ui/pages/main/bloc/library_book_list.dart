import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';

enum LibraryBookListStateCode { normal, selecting, unLoad, loading }

class LibraryBookListCubit extends Cubit<LibraryBookListState> {
  LibraryBookListCubit()
      : super(const LibraryBookListState(LibraryBookListStateCode.unLoad, [], <String>{}, <String>{}));

  /// Get the list of latest books.
  void refresh() async {
    LibraryBookListState initState =
        const LibraryBookListState(LibraryBookListStateCode.loading, [], <String>{}, <String>{});
    emit(initState);
    List<String> list = await FileProcess.getLibraryBookList();
    emit(initState.copyWith(newCode: LibraryBookListStateCode.normal, newList: list));
  }

  /// Add the book into the selected list.
  void addSelect(LibraryBookListState state, String name) {
    if (state.selectedBook.contains(name)) {
      return;
    }
    Set<String> selectedSet = Set<String>.from(state.selectedBook);
    selectedSet.add(name);
    emit(state.copyWith(newCode: LibraryBookListStateCode.selecting, newSelectedSet: selectedSet));
  }

  /// Select all books except those the slide menu is open.
  void allSelect(LibraryBookListState state) {
    emit(state.copyWith(
      newCode: LibraryBookListStateCode.selecting,
      newSelectedSet: state.bookList.toSet().difference(state.slidedBook),
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
    emit(state.copyWith(newCode: stateCode, newSelectedSet: selectedSet));
  }

  /// Clear the selected list.
  void clearSelect(LibraryBookListState state) {
    emit(state.copyWith(newCode: LibraryBookListStateCode.normal,newSelectedSet: <String>{}));
  }

  /// Add the book into the sliding set.
  void addSlide(LibraryBookListState state, String name) {
    if (state.slidedBook.contains(name)) {
      return;
    }
    Set<String> slideSet = Set<String>.from(state.slidedBook);
    slideSet.add(name);
    emit(state.copyWith(newSlidedSet: slideSet));
  }

  /// Remove the book from the sliding set.
  void removeSlide(LibraryBookListState state, String name) {
    if (!state.slidedBook.contains(name)) {
      return;
    }
    Set<String> slideSet = Set<String>.from(state.slidedBook);
    slideSet.remove(name);
    emit(state.copyWith(newSlidedSet: slideSet));
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
    LibraryBookListStateCode? newCode,
    List<String>? newList,
    Set<String>? newSelectedSet,
    Set<String>? newSlidedSet,
  }) {
    return LibraryBookListState(
      newCode ?? code,
      newList ?? bookList,
      newSelectedSet ?? selectedBook,
      newSlidedSet ?? slidedBook,
    );
  }

  @override
  List<Object?> get props => [code, bookList, selectedBook, slidedBook];
}
