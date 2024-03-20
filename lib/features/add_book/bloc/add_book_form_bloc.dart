import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/book_object.dart';
import '../../../shared/verify_utility.dart';

enum AddBookFormNameStateCode { valid, blank, invalid, exists }

class AddBookFormCubit extends Cubit<AddBookFormState> {
  AddBookFormCubit() : super(const AddBookFormState());

  BookObject data = BookObject();

  AddBookFormNameStateCode nameVerify(String? name) {
    if (name == null || name == '') {
      return AddBookFormNameStateCode.blank;
    }

    if (!VerifyUtility.isFolderNameValid(name)) {
      return AddBookFormNameStateCode.invalid;
    }

    final BookObject inputBookObject = BookObject.fromName(name);
    if (inputBookObject.isExists()) {
      return AddBookFormNameStateCode.exists;
    }

    // Name verification passed.
    data.name = name;
    return AddBookFormNameStateCode.valid;
  }

  Future<bool> submit() async {
    return await data.create();
  }
}

class AddBookFormState extends Equatable {
  const AddBookFormState();

  @override
  List<Object?> get props => [];
}
