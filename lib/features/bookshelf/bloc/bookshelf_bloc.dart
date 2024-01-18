import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/book_process.dart';

enum BookshelfStateCode { normal, selecting, empty, unload, loading }

class BookshelfCubit extends Cubit<BookshelfState> {
  BookshelfCubit() : super(const BookshelfState());

  void refresh() async {
    List<BookObject> list = await BookProcess.getList();
    BookshelfStateCode code = list.isEmpty ? BookshelfStateCode.empty : BookshelfStateCode.normal;
    emit(BookshelfState(code: code, bookList: list));
  }

  void addSelect(String name) {
    Set<String> selectedSet = Set<String>.from(state.selectedSet);
    selectedSet.add(name);
    emit(state.copyWith(code: BookshelfStateCode.selecting, selectedSet: selectedSet));
  }

  void removeSelect(String name) {
    Set<String> selectedSet = Set<String>.from(state.selectedSet);
    selectedSet.remove(name);
    emit(state.copyWith(
      code: selectedSet.isEmpty ? BookshelfStateCode.normal : BookshelfStateCode.selecting,
      selectedSet: selectedSet,
    ));
  }

  void allSelect() {
    final Set<String> selectedSet = state.bookList.map((book) => book.name).toSet();
    emit(state.copyWith(code: BookshelfStateCode.selecting, selectedSet: selectedSet));
  }

  void clearSelect() {
    emit(state.copyWith(code: BookshelfStateCode.normal, selectedSet: const {}));
  }

  void deleteSelect() async {
    for (String book in state.selectedSet) {
      BookObject target = BookObject(name: book);
      await target.delete();
    }
    refresh();
  }
}

class BookshelfState extends Equatable {
  final BookshelfStateCode code;
  final List<BookObject> bookList;
  final Set<String> selectedSet;

  const BookshelfState({
    this.code = BookshelfStateCode.unload,
    this.bookList = const [],
    this.selectedSet = const {},
  });

  BookshelfState copyWith({
    BookshelfStateCode? code,
    List<BookObject>? bookList,
    Set<String>? selectedSet,
    bool? refreshTrigger,
  }) {
    return BookshelfState(
      code: code ?? this.code,
      bookList: bookList ?? this.bookList,
      selectedSet: selectedSet ?? this.selectedSet,
    );
  }

  @override
  List<Object?> get props => [code, bookList, selectedSet];
}
