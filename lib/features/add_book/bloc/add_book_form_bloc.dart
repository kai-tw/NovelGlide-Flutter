import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/book_object.dart';
import '../../../shared/verify_utility.dart';

enum AddBookFormNameStateCode { valid, blank, invalid, exists }

enum AddBookFormCoverStateCode { blank, valid }

class AddBookFormCubit extends Cubit<AddBookFormState> {
  AddBookFormCubit() : super(const AddBookFormState());

  BookObject data = BookObject();

  void nameVerify(String name) async {
    data.name = name;
    if (name == '') {
      emit(const AddBookFormState());
    } else if (!VerifyUtility.isFolderNameValid(name)) {
      emit(const AddBookFormState(nameStateCode: AddBookFormNameStateCode.invalid));
    } else if (await data.isExists()) {
      emit(const AddBookFormState(nameStateCode: AddBookFormNameStateCode.exists));
    } else {
      // Name verification passed.
      emit(state.copyWith(nameStateCode: AddBookFormNameStateCode.valid));
    }
  }

  Future<bool> submit() async {
    return await data.create();
  }
}

class AddBookFormState extends Equatable {
  final AddBookFormNameStateCode nameStateCode;

  const AddBookFormState({
    this.nameStateCode = AddBookFormNameStateCode.blank,
  });

  AddBookFormState copyWith({
    AddBookFormNameStateCode? nameStateCode,
  }) {
    return AddBookFormState(
      nameStateCode: nameStateCode ?? this.nameStateCode,
    );
  }

  @override
  List<Object?> get props => [nameStateCode];
}
