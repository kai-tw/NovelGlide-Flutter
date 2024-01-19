import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/book_process.dart';
import '../../../shared/input_verify.dart';

enum EditBookNameStateCode { valid, blank, invalid, exists, same }

enum EditBookCoverStateCode { blank, valid, same }

class EditBookFormCubit extends Cubit<EditBookFormState> {
  EditBookFormCubit(this.data) : super(EditBookFormState(formValue: BookObject.fromObject(data)));

  BookObject data;
  final ImagePicker _imagePicker = ImagePicker();

  void nameVerify(String name) async {
    state.formValue.name = name;
    if (name == '') {
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.blank));
    } else if (!InputVerify.isFolderNameValid(name)) {
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.invalid));
    } else if (await BookProcess.isExists(name)) {
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.exists));
    } else {
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.valid));
    }
  }

  void pickCoverImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    state.formValue.coverFile = image == null ? null : File(image.path);
    emit(state.copyWith(coverStateCode: image == null ? EditBookCoverStateCode.blank : EditBookCoverStateCode.valid));
  }

  void removeCoverImage() {
    state.formValue.coverFile = null;
    emit(state.copyWith(coverStateCode: EditBookCoverStateCode.blank));
  }

  Future<bool> submit() async {
    return await data.rename(state.formValue);
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
