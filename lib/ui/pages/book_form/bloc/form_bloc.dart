import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';
import 'package:novelglide/core/input_verify.dart';

enum BookFormType { add, edit, multiEdit }

enum BookFormNameState { nothing, blank, invalid, exists, same }

class BookFormData {
  // Share bookNamePattern with oldBookName
  String oldName = '';
  String newName = '';
  Set<String> selectedBooks = <String>{};
}

class BookFormCubit extends Cubit<BookFormState> {
  BookFormCubit(this.formType) : super(const BookFormState());

  BookFormType formType;
  BookFormData data = BookFormData();

  void oldNameVerify(BookFormState state, String? name) {
    _bookNameVerify(name).then((result) {
      data.oldName = name!;
      result = result == BookFormNameState.exists ? BookFormNameState.nothing : result;
      emit(state.copyWith(oldNameState: result, namePreview: getNamePreview()));
    });
  }

  void newNameVerify(BookFormState state, String? name) async {
    BookFormNameState newState = BookFormNameState.blank;

    // Verify data.
    switch (formType) {
      case BookFormType.add:
        newState = await _bookNameVerify(name);
        break;
      case BookFormType.edit:
        newState = await _bookNameVerify(name);
        newState = name == data.oldName ? BookFormNameState.same : newState;
        break;
      case BookFormType.multiEdit:
        newState = BookFormNameState.nothing;
        for (String item in data.selectedBooks) {
          BookFormNameState itemState = await _bookNameVerify(item.replaceAll(data.oldName, name ?? ''));
          if (itemState != BookFormNameState.nothing) {
            newState = itemState;
            break;
          }
        }
        break;
    }
    debugPrint(newState.toString());

    // Save data & emit the state.
    data.newName = name!;
    emit(state.copyWith(newNameState: newState, namePreview: getNamePreview()));
  }

  Future<BookFormNameState> _bookNameVerify(String? name) async {
    if (name == null || name == '') {
      return BookFormNameState.blank;
    }
    if (!InputVerify.isFolderNameValid(name)) {
      return BookFormNameState.invalid;
    }
    if (await FileProcess.isBookExists(name)) {
      return BookFormNameState.exists;
    }
    return BookFormNameState.nothing;
  }

  String getNamePreview() {
    return formType == BookFormType.multiEdit ? data.selectedBooks.first.replaceAll(data.oldName, data.newName) : '';
  }

  Future<bool> submitData() async {
    switch (formType) {
      case BookFormType.add:
        return await FileProcess.createBook(data.newName);
      case BookFormType.edit:
        return await FileProcess.renameBook(data.oldName, data.newName);
      case BookFormType.multiEdit:
        return await FileProcess.renameBookBatch(data.selectedBooks, data.oldName, data.newName);
      default:
        return false;
    }
  }
}

class BookFormState extends Equatable {
  final BookFormNameState? oldNameState;
  final BookFormNameState? newNameState;
  final String? namePreview;

  /// Initialization.
  const BookFormState({this.oldNameState, this.newNameState, this.namePreview});

  BookFormState copyWith({
    BookFormNameState? oldNameState,
    BookFormNameState? newNameState,
    String? namePreview,
  }) {
    return BookFormState(
      oldNameState: oldNameState ?? this.oldNameState,
      newNameState: newNameState ?? this.newNameState,
      namePreview: namePreview ?? this.namePreview,
    );
  }

  @override
  List<Object?> get props => [oldNameState, newNameState, namePreview];
}
