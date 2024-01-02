import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';
import 'package:novelglide/core/input_verify.dart';

enum AddBookFormBookNameErrorCode {
  nothing,
  blank,
  invalid,
  exists
}

class AddBookFormCubit extends Cubit<AddBookFormState> {
  AddBookFormCubit():super(const AddBookFormState(AddBookFormBookNameErrorCode.nothing));

  void bookNameVerify(AddBookFormState state, String? name) async {
    if (name == null) {
      emit(state.copyWith(bookNameErrorCode: AddBookFormBookNameErrorCode.blank));
      return;
    }
    if (!InputVerify.isFolderNameValid(name)) {
      emit(state.copyWith(bookNameErrorCode: AddBookFormBookNameErrorCode.invalid));
      return;
    }
    if (await FileProcess.isBookExists(name)) {
      emit(state.copyWith(bookNameErrorCode: AddBookFormBookNameErrorCode.exists));
      return;
    }
  }
}

class AddBookFormState extends Equatable{
  final AddBookFormBookNameErrorCode bookNameErrorCode;

  const AddBookFormState(this.bookNameErrorCode);

  AddBookFormState copyWith({AddBookFormBookNameErrorCode? bookNameErrorCode}) {
    return AddBookFormState(bookNameErrorCode!);
  }

  @override
  List<Object?> get props => [bookNameErrorCode];
}