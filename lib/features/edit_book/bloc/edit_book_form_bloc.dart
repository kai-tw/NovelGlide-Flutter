import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/book_object.dart';
import '../../../shared/verify_utility.dart';

enum EditBookNameStateCode { valid, blank, invalid, exists, same }

enum EditBookCoverStateCode { blank, valid, same }

class EditBookFormCubit extends Cubit<EditBookFormState> {
  EditBookFormCubit(this.data) : super(EditBookFormState(formValue: BookObject.fromObject(data)));

  BookObject data;

  void nameVerify(String name) async {
    state.formValue.name = name;
    if (name == '') {
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.blank));
    } else if (!VerifyUtility.isFolderNameValid(name)) {
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.invalid));
    } else if (state.formValue.isExists()) {
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.exists));
    } else {
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.valid));
    }
  }

  Future<bool> submit() async {
    return data.rename(state.formValue);
  }
}

class EditBookFormState extends Equatable {
  final EditBookNameStateCode nameStateCode;
  final EditBookCoverStateCode coverStateCode;
  final BookObject formValue;

  const EditBookFormState({
    required this.formValue,
    this.nameStateCode = EditBookNameStateCode.same,
    this.coverStateCode = EditBookCoverStateCode.same,
  });

  EditBookFormState copyWith({
    EditBookNameStateCode? nameStateCode,
    EditBookCoverStateCode? coverStateCode,
    BookObject? formValue,
  }) {
    return EditBookFormState(
      nameStateCode: nameStateCode ?? this.nameStateCode,
      coverStateCode: coverStateCode ?? this.coverStateCode,
      formValue: formValue ?? this.formValue,
    );
  }

  @override
  List<Object?> get props => [nameStateCode, coverStateCode, formValue];
}
