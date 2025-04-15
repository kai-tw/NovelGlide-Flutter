import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/book_repository.dart';

part 'state.dart';

/// Cubit to manage the state of adding a book.
class BookAddCubit extends Cubit<BookAddState> {
  static final allowedExtensions = ['epub'];

  BookAddCubit() : super(const BookAddState());

  /// Allows the user to pick a file.
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    final path = result?.files.single.path;

    if (!isClosed) {
      emit(
        BookAddState(
          file: path != null ? File(path) : null,
        ),
      );
    }
  }

  void removeFile() => emit(const BookAddState());
}
