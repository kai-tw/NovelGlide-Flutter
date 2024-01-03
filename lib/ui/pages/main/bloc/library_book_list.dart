import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';

class LibraryBookListCubit extends Cubit<LibraryBookListState> {
  LibraryBookListCubit() : super(const LibraryBookListState(false, []));

  void refresh() async {
    List<Directory> list = await FileProcess.getLibraryBookList();
    emit(LibraryBookListState(true, list));
  }
}

class LibraryBookListState extends Equatable {
  final bool isLoaded;
  final List<Directory> bookList;

  const LibraryBookListState(this.isLoaded, this.bookList);

  @override
  List<Object?> get props => [isLoaded, bookList];
}