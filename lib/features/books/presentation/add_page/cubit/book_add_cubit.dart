import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/book_add_use_case.dart';
import '../../../domain/use_cases/book_clear_temporary_picked_files_use_case.dart';
import '../../../domain/use_cases/book_exists_use_case.dart';
import '../../../domain/use_cases/book_get_allowed_extensions_use_case.dart';
import '../../../domain/use_cases/book_is_file_valid_use_case.dart';
import '../../../domain/use_cases/book_pick_use_case.dart';
import 'book_add_item_state.dart';
import 'book_add_state.dart';

/// Cubit to manage the state of adding a book_service.
class BookAddCubit extends Cubit<BookAddState> {
  BookAddCubit(
    this._addBooksUseCase,
    this._bookExistsUseCase,
    this._clearTemporaryPickedBooksUseCase,
    this._getBookAllowedExtensionsUseCase,
    this._pickBooksUseCase,
    this._isFileValidUseCase,
  ) : super(const BookAddState());

  final BookAddUseCase _addBooksUseCase;
  final BookExistsUseCase _bookExistsUseCase;
  final BookClearTemporaryPickedFilesUseCase _clearTemporaryPickedBooksUseCase;
  final BookGetAllowedExtensionsUseCase _getBookAllowedExtensionsUseCase;
  final BookPickUseCase _pickBooksUseCase;
  final BookIsFileValidUseCase _isFileValidUseCase;

  List<String> get allowedExtensions => _getBookAllowedExtensionsUseCase();

  /// Allows the user to pick a file.
  Future<void> pickFile() async {
    final Set<String> selectedFileName =
        state.itemState.map((BookAddItemState s) => s.absolutePath).toSet();

    // Pick file
    final Set<String> pickedFileSet = await _pickBooksUseCase(selectedFileName);
    final Set<BookAddItemState> stateSet = <BookAddItemState>{};

    // Convert to item state.
    for (String path in pickedFileSet) {
      stateSet.add(BookAddItemState(
        absolutePath: path,
        existsInLibrary: await _bookExistsUseCase(path),
        isTypeValid: _isFileValidUseCase(path),
      ));
    }

    if (!isClosed) {
      emit(BookAddState(itemState: stateSet));
    }
  }

  Future<void> removeFile(BookAddItemState itemState) async {
    final Set<BookAddItemState> fileSet =
        Set<BookAddItemState>.from(state.itemState);

    // Remove from list.
    fileSet.remove(itemState);

    // Update state.
    emit(BookAddState(
      itemState: fileSet,
    ));
  }

  Future<void> submit() async {
    await _addBooksUseCase(state.itemState
        .map((BookAddItemState itemState) => itemState.absolutePath)
        .toSet());
  }

  @override
  Future<void> close() async {
    // Clear temporary files.
    _clearTemporaryPickedBooksUseCase();
    return super.close();
  }
}
