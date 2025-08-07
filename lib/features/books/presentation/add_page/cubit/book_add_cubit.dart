import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../book_service.dart';
import '../../../domain/use_cases/add_books_use_case.dart';
import '../../../domain/use_cases/book_exists_use_case.dart';
import '../../../domain/use_cases/clear_temporary_picked_books_use_case.dart';
import '../../../domain/use_cases/get_book_allowed_extensions_use_case.dart';
import '../../../domain/use_cases/pick_books_use_case.dart';
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
  ) : super(const BookAddState());

  final AddBooksUseCase _addBooksUseCase;
  final BookExistsUseCase _bookExistsUseCase;
  final ClearTemporaryPickedBooksUseCase _clearTemporaryPickedBooksUseCase;
  final GetBookAllowedExtensionsUseCase _getBookAllowedExtensionsUseCase;
  final PickBooksUseCase _pickBooksUseCase;

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
        isTypeValid: BookService.repository.isFileValid(File(path)),
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
