import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../toolbox/verify_utility.dart';

enum EditBookNameStateCode { valid, blank, invalid, exists, same }

class EditBookFormCubit extends Cubit<EditBookFormState> {
  EditBookFormCubit(this.oldData) : newData = BookData.fromObject(oldData), super(const EditBookFormState());

  final BookData oldData;
  final BookData newData;

  EditBookNameStateCode nameVerify(String? name) {
    if (name == '' || name == null) {
      return EditBookNameStateCode.blank;
    }

    if (name == oldData.name) {
      return EditBookNameStateCode.same;
    }

    if (!VerifyUtility.isFolderNameValid(name)) {
      return EditBookNameStateCode.invalid;
    }

    final BookData inputBookObject = BookData.fromName(name);
    if (inputBookObject.isExists()) {
      return EditBookNameStateCode.exists;
    }

    newData.name = name;
    return EditBookNameStateCode.valid;
  }

  Future<bool> submit() async {
    return await oldData.modify(newData);
  }
}

class EditBookFormState extends Equatable {
  const EditBookFormState();

  @override
  List<Object?> get props => [];
}
