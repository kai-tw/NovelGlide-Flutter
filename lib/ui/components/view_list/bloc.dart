import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';

enum ViewListStateCode { normal, selecting, unload, loading, empty }

abstract class ViewListCubit extends Cubit<ViewListState> {
  ViewListCubit() : super(const ViewListState());

  /// Get the list of latest books.
  void refresh();

  /// Add the book into the selected list.
  void addSelect(ViewListState state, String name) {
    if (state.selectedSet.contains(name)) {
      return;
    }
    Set<String> selectedSet = Set<String>.from(state.selectedSet);
    selectedSet.add(name);
    emit(state.copyWith(code: ViewListStateCode.selecting, selectedBooks: selectedSet));
  }

  /// Select all books except those the slide menu is open.
  void allSelect(ViewListState state) {
    emit(state.copyWith(
      code: ViewListStateCode.selecting,
      selectedBooks: state.bookList.toSet().difference(state.slidedItem),
    ));
  }

  /// Remove the book from the selected list.
  void removeSelect(ViewListState state, String name) {
    if (!state.selectedSet.contains(name)) {
      return;
    }
    Set<String> selectedSet = Set<String>.from(state.selectedSet);
    selectedSet.remove(name);
    ViewListStateCode stateCode =
    selectedSet.isNotEmpty ? ViewListStateCode.selecting : ViewListStateCode.normal;
    emit(state.copyWith(code: stateCode, selectedBooks: selectedSet));
  }

  /// Clear the selected list.
  void clearSelect(ViewListState state) {
    emit(state.copyWith(code: ViewListStateCode.normal, selectedBooks: <String>{}));
  }

  /// Add the book into the sliding set.
  void addSlide(ViewListState state, String name) {
    if (state.slidedItem.contains(name)) {
      return;
    }

    // If the book is selected, remove it from the selection set.
    ViewListStateCode code = state.code;
    Set<String> selectedSet = Set<String>.from(state.selectedSet);
    if (state.selectedSet.contains(name)) {
      selectedSet.remove(name);
      code = selectedSet.isEmpty ? ViewListStateCode.normal : ViewListStateCode.selecting;
    }

    // Add the book into the sliding set.
    Set<String> slideSet = Set<String>.from(state.slidedItem);
    slideSet.add(name);
    emit(state.copyWith(code: code, selectedBooks: selectedSet, slidedBook: slideSet));
  }

  /// Remove the book from the sliding set.
  void removeSlide(ViewListState state, String name) {
    if (!state.slidedItem.contains(name)) {
      return;
    }
    Set<String> slideSet = Set<String>.from(state.slidedItem);
    slideSet.remove(name);
    emit(state.copyWith(slidedBook: slideSet));
  }

  /// Delete all books selected by the user.
  void deleteSelectBook(ViewListState state) {
    for (var item in state.selectedSet) {
      FileProcess.deleteBook(item);
    }
    refresh();
  }

  /// Delete the book by the user.
  void deleteBook(ViewListState state, String bookName) {
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
class ViewListState<T> extends Equatable {
  final ViewListStateCode code;
  final List<String> bookList;
  final Set<T> selectedSet;
  final T slidedItem;

  const ViewListState({
    this.code = ViewListStateCode.unload,
    this.bookList = const [],
    this.selectedSet = const {},
    this.slidedItem = T(),
  });

  ViewListState copyWith({
    ViewListStateCode? code,
    List<String>? bookList,
    Set<String>? selectedSet,
    String? slidedItem,
  }) {
    return ViewListState(
      code: code ?? this.code,
      bookList: bookList ?? this.bookList,
      selectedSet: selectedSet ?? this.selectedSet,
      slidedItem: slidedItem ?? this.slidedItem,
    );
  }

  @override
  List<Object?> get props => [code, bookList, selectedSet, slidedItem];
}
