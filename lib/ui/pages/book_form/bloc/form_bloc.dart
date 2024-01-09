import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';
import 'package:novelglide/core/input_verify.dart';

enum BookFormType { add, edit, multiEdit }

enum BookFormNameState { nothing, blank, invalid, exists }

class BookFormData {
  String bookNamePattern = '';
  String newBookName = '';

  void save({String? bookNamePattern, String? newBookName}) {
    this.bookNamePattern = bookNamePattern ?? this.bookNamePattern;
    this.newBookName = newBookName ?? this.newBookName;
  }
}

class BookFormCubit extends Cubit<BookFormState> {
  BookFormCubit() : super(BookFormState());

  BookFormData data = BookFormData();

  void patternVerify(BookFormState state, String? name) {
    _bookNameVerify(name).then((result) {
      emit(state.copyWith(newNameState: result));
    });
  }

  void nameVerify(BookFormState state, String? name) {
    _bookNameVerify(name).then((result) {
      emit(state.copyWith(newNameState: result));
    });
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

  Future<bool> submitData(BookFormState state) async {
    switch (state.formType) {
      case BookFormType.add:
        return await FileProcess.createBook(data.newBookName);
      case BookFormType.edit:
        return false;
      case BookFormType.multiEdit:
        return false;
      default:
        return false;
    }
  }
}

class BookFormState extends Equatable {
  late final BookFormType? formType;
  late final BookFormNameState? oldNameState;
  late final BookFormNameState? newNameState;

  /// Initialization.
  BookFormState({
    BookFormType? formType,
    BookFormNameState? oldNameState,
    BookFormNameState? newNameState,
  }) {
    this.formType = formType ?? BookFormType.add;
    this.oldNameState = oldNameState ?? BookFormNameState.blank;
    this.newNameState = newNameState ?? BookFormNameState.blank;
  }

  BookFormState copyWith({
    BookFormType? formType,
    BookFormNameState? oldNameState,
    BookFormNameState? newNameState,
  }) {
    return BookFormState(
      formType: formType ?? this.formType,
      oldNameState: oldNameState ?? this.oldNameState,
      newNameState: newNameState ?? this.newNameState,
    );
  }

  @override
  List<Object?> get props => [newNameState];
}
