part of '../../../book_service.dart';

/// Cubit to manage the state of adding a book_service.
class BookAddCubit extends Cubit<BookAddState> {
  BookAddCubit() : super(const BookAddState());

  List<String> get allowedExtensions =>
      BookService.repository.allowedExtensions;

  /// Allows the user to pick a file.
  Future<void> pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      allowMultiple: true,
    );

    final Set<BookAddItemState> itemStateSet =
        Set<BookAddItemState>.from(state.itemState);
    final List<PlatformFile> fileList = result?.files ?? <PlatformFile>[];

    for (PlatformFile file in fileList) {
      if (file.path != null) {
        if (state.itemState.any((BookAddItemState itemState) =>
            basename(itemState.absolutePath) == basename(file.path!))) {
          // If the file is already in the list,
          // delete it from temporary storage.
          File(file.path!).deleteSync();
        } else {
          itemStateSet.add(BookAddItemState(
            absolutePath: file.path!,
            isExistsInLibrary: await BookService.repository.exists(file.path!),
            isMimeValid: BookService.repository.isMimeValid(File(file.path!)),
          ));
        }
      }
    }

    if (!isClosed) {
      emit(BookAddState(
        itemState: itemStateSet,
      ));
    }
  }

  Future<void> removeFile(BookAddItemState itemState) async {
    final Set<BookAddItemState> fileSet =
        Set<BookAddItemState>.from(state.itemState);
    fileSet.remove(itemState);
    emit(BookAddState(
      itemState: fileSet,
    ));
  }

  Future<void> submit() async {
    for (BookAddItemState itemState in state.itemState) {
      await BookService.repository.addBook(itemState.absolutePath);
    }
  }
}
