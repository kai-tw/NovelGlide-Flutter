import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';

class LibraryBookListCubit extends Cubit<LibraryBookListState> {
  LibraryBookListCubit() : super(const LibraryBookListState(false, [], <String>{}));

  void refresh() async {
    List<String> list = await FileProcess.getLibraryBookList();
    emit(LibraryBookListState(true, list, const <String>{}));
  }

  void addSelect(LibraryBookListState state, String name) {
    state.bookList.add(name);
    emit(state.copyWith());
  }

  void removeSelect(LibraryBookListState state, String name) {
    state.bookList.remove(name);
    emit(state.copyWith());
  }

  void clearSelect(LibraryBookListState state) {
    state.bookList.clear();
    emit(state.copyWith());
  }
}

class LibraryBookListState extends Equatable {
  final bool isLoaded;
  final List<String> bookList;
  final Set<String> selectedBook;

  const LibraryBookListState(this.isLoaded, this.bookList, this.selectedBook);

  LibraryBookListState copyWith() {
    return LibraryBookListState(isLoaded, bookList, selectedBook);
  }

  @override
  List<Object?> get props => [isLoaded, bookList, selectedBook];
}