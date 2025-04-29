import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/book_repository.dart';

part 'state.dart';

/// Cubit to manage the state of adding a book.
class BookAddCubit extends Cubit<BookAddState> {
  BookAddCubit() : super(const BookAddState());

  static final List<String> allowedExtensions = <String>['epub'];

  /// Allows the user to pick a file.
  Future<void> pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    final String? path = result?.files.single.path;

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
