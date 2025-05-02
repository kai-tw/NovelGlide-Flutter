import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

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
      // allowedExtensions is not working on Android.
      type: Platform.isAndroid ? FileType.any : FileType.custom,
      allowedExtensions: Platform.isAndroid ? null : allowedExtensions,
      allowMultiple: true,
    );

    final Set<String> newFileSet = (result?.files ?? <PlatformFile>[])
        .where((PlatformFile file) {
          // Filter out files that are already in the set.
          return file.path != null &&
              !state.pathSet
                  .any((String path) => basename(path) == basename(file.path!));
        })
        .map((PlatformFile file) => file.path!)
        .toSet();

    newFileSet.addAll(state.pathSet);

    if (!isClosed) {
      emit(BookAddState(pathSet: newFileSet));
    }
  }

  void removeFile(String filePath) {
    final Set<String> fileList = Set<String>.from(state.pathSet);
    fileList.remove(filePath);
    emit(BookAddState(pathSet: fileList));
  }

  void submit() {
    state.pathSet.forEach(BookRepository.add);
  }
}
