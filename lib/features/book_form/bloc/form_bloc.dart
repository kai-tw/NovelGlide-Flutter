import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/shared/file_process.dart';
import 'package:novelglide/shared/input_verify.dart';

enum BookFormType { add, edit, multiEdit }

enum BookFormNameState { nothing, blank, invalid, exists, same }

class BookFormData {
  // Share bookNamePattern with oldBookName
  String oldName = '';
  String newName = '';
  String pattern = '';
  Set<String> selectedBooks = <String>{};
}

class BookFormCubit extends Cubit<BookFormState> {
  BookFormCubit(this.formType) : super(const BookFormState());

  BookFormType formType;
  BookFormData data = BookFormData();

  void oldNameVerify(BookFormState state, String? name) async {
    data.oldName = name ?? '';
    BookFormNameState resultState = await _bookNameVerify(name);
    resultState = resultState == BookFormNameState.exists ? BookFormNameState.nothing : resultState;
    emit(state.copyWith(oldNameState: resultState));
  }

  void patternVerify(BookFormState state, String? name) async {
    data.pattern = name ?? '';
    BookFormNameState resultState = await _bookNameVerify(name);
    resultState = resultState == BookFormNameState.exists ? BookFormNameState.nothing : resultState;
    emit(state.copyWith(patternState: resultState, namePreview: getNamePreview()));
  }

  void newNameVerify(BookFormState state, String? name) async {
    data.newName = name ?? '';
    BookFormNameState resultState;

    // Verify data.
    switch (formType) {
      case BookFormType.add:
        resultState = await _bookNameVerify(name);
        break;
      case BookFormType.edit:
        resultState = name == data.oldName ? BookFormNameState.same : await _bookNameVerify(name);
        break;
      case BookFormType.multiEdit:
        resultState = BookFormNameState.nothing;
        for (String item in data.selectedBooks) {
          BookFormNameState itemState = await _bookNameVerify(item.replaceAll(data.oldName, name ?? ''));
          if (itemState != BookFormNameState.nothing) {
            resultState = itemState;
            break;
          }
        }
        break;
    }
    emit(state.copyWith(newNameState: resultState, namePreview: getNamePreview()));
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
    if (formType != BookFormType.multiEdit) {
      return '';
    }
    String sampleString = data.selectedBooks.first;
    if (data.pattern == '') {
      return sampleString;
    }
    return sampleString.replaceAll(data.pattern, data.newName);
  }

  Future<bool> submitData() async {
    switch (formType) {
      case BookFormType.add:
        return await FileProcess.createBook(data.newName);
      case BookFormType.edit:
        return await FileProcess.renameBook(data.oldName, data.newName);
      case BookFormType.multiEdit:
        return await FileProcess.renameBookBatch(data.selectedBooks, data.pattern, data.newName);
      default:
        return false;
    }
  }
}

class BookFormState extends Equatable {
  final BookFormNameState? oldNameState;
  final BookFormNameState? newNameState;
  final BookFormNameState? patternState;
  final String? namePreview;

  /// Initialization.
  const BookFormState({this.oldNameState, this.newNameState, this.patternState, this.namePreview});

  BookFormState copyWith({
    BookFormNameState? oldNameState,
    BookFormNameState? newNameState,
    BookFormNameState? patternState,
    String? namePreview,
  }) {
    return BookFormState(
      oldNameState: oldNameState ?? this.oldNameState,
      newNameState: newNameState ?? this.newNameState,
      patternState: patternState ?? this.patternState,
      namePreview: namePreview ?? this.namePreview,
    );
  }

  @override
  List<Object?> get props => [oldNameState, newNameState, patternState, namePreview];
}
