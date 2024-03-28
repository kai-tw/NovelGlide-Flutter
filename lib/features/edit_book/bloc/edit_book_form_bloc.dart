import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/book_object.dart';
import '../../../shared/verify_utility.dart';

enum EditBookNameStateCode { valid, blank, invalid, exists, same }

class EditBookFormCubit extends Cubit<EditBookFormState> {
  EditBookFormCubit(this.oldData) : newData = BookObject.fromObject(oldData), super(const EditBookFormState());

  final BookObject oldData;
  final BookObject newData;

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

    final BookObject inputBookObject = BookObject.fromName(name);
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
