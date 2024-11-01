part of '../book_add_dialog.dart';

/// Cubit to manage the state of adding a book.
class _Cubit extends Cubit<_State> {
  _Cubit() : super(const _State());

  /// Allows the user to pick a file.
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub'],
    );

    if (!isClosed) {
      emit(_State(file: _getFileFromResult(result)));
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
  void removeFile() => emit(const _State());

  /// Helper method to extract a File from the FilePickerResult.
  File? _getFileFromResult(FilePickerResult? result) {
    return result?.files.single.path != null
        ? File(result!.files.single.path!)
        : null;
  }
}

/// State representing the current file being added.
class _State extends Equatable {
  final File? file;

  @override
  List<Object?> get props => [file];

  const _State({this.file});
}
