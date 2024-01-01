import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AddBookFormBookNameErrorCode {
  nothing,
  blank,
  invalid,
  exists
}

class AddBookFormCubit extends Cubit<AddBookFormState> {
  AddBookFormCubit():super(const AddBookFormState(AddBookFormBookNameErrorCode.nothing));

  void bookNameVerify(String? name) async {
    if (name == null) {
      emit(const AddBookFormState(AddBookFormBookNameErrorCode.blank));
    }
  }
}

class AddBookFormState extends Equatable{
  final AddBookFormBookNameErrorCode bookNameErrorCode;

  const AddBookFormState(this.bookNameErrorCode);

  @override
  List<Object?> get props => [bookNameErrorCode];
}