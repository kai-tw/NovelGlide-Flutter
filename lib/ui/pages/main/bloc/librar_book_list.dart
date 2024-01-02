import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';

class LibraryBookListCubit extends Cubit<LibraryBookListState> {
  LibraryBookListCubit() : super(const LibraryBookListState([]));

  void fetchBookList() {
    FileProcess.getLibraryBookList().then((list) {
      emit(LibraryBookListState(list));
    });
  }
}

class LibraryBookListState extends Equatable {
  final List<Directory> bookList;

  const LibraryBookListState(this.bookList);

  @override
  List<Object?> get props => [];
}