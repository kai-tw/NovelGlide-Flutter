part of '../../../book_service.dart';

/// Cubit to manage the state of adding a book_service.
class BookAddCubit extends Cubit<BookAddState> {
  BookAddCubit() : super(const BookAddState());

  static final List<String> allowedExtensions = <String>['epub'];

  /// Allows the user to pick a file.
  Future<void> pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
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
    state.pathSet.forEach(BookService.repository.add);
  }
}
