import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/mime_resolver.dart';
import '../../../data/repository/book_repository.dart';

part 'book_add_state.dart';

/// Cubit to manage the state of adding a book.
class BookAddCubit extends Cubit<BookAddState> {
  BookAddCubit() : super(const BookAddState());

  static final List<String> allowedExtensions = <String>['epub'];

  /// Allows the user to pick a file.
  Future<void> pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
      // allowedExtensions: allowedExtensions,
    );

    if (!isClosed) {
      emit(
        BookAddState(
          fileList: (result?.files ?? <PlatformFile>[])
              .where((PlatformFile file) => file.path != null)
              .map((PlatformFile file) => File(file.path!))
              .toList(),
        ),
      );
    }
  }

  void removeFile() => emit(const BookAddState());

  void submit() {
    for (final File file in state.fileList) {
      BookRepository.add(file.path);
    }
    emit(const BookAddState());
  }
}
