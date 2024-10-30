import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../exceptions/file_exceptions.dart';
import '../../../repository/book_repository.dart';

/// Cubit to manage the state of adding a book.
class BookAddCubit extends Cubit<BookAddState> {
  BookAddCubit() : super(const BookAddState());

  /// Allows the user to pick a file.
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub'],
    );

    if (!isClosed) {
      emit(BookAddState(file: _getFileFromResult(result)));
    }
  }

  /// Submits the selected file to the library.
  void submit() {
    try {
      BookRepository.add(state.file!.path);
    } on FileDuplicatedException catch (_) {
      rethrow;
    }
  }

  /// Removes the selected file from the state.
  void removeFile() => emit(const BookAddState());

  /// Helper method to extract a File from the FilePickerResult.
  File? _getFileFromResult(FilePickerResult? result) {
    return result?.files.single.path != null
        ? File(result!.files.single.path!)
        : null;
  }
}

/// State representing the current file being added.
class BookAddState extends Equatable {
  final File? file;

  @override
  List<Object?> get props => [file];

  const BookAddState({this.file});
}
