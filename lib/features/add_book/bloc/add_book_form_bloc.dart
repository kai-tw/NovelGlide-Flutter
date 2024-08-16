import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../toolbox/verify_utility.dart';

enum AddBookFormNameStateCode { valid, blank, invalid, exists }

class AddBookFormCubit extends Cubit<AddBookFormState> {
  AddBookFormCubit() : super(const AddBookFormState());

  BookData data = BookData();

  AddBookFormNameStateCode nameVerify(String? name) {
    if (name == null || name == '') {
      return AddBookFormNameStateCode.blank;
    }

    if (!VerifyUtility.isFolderNameValid(name)) {
      return AddBookFormNameStateCode.invalid;
    }

    final BookData inputBookObject = BookData.fromName(name);
    if (inputBookObject.isExist()) {
      return AddBookFormNameStateCode.exists;
    }

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
