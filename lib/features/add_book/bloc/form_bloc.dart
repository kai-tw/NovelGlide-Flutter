import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/book_process.dart';
import '../../../shared/input_verify.dart';

enum AddBookNameStateCode { valid, blank, invalid, exists }

enum AddBookCoverStateCode { blank, valid }

class AddBookFormCubit extends Cubit<AddBookFormState> {
  AddBookFormCubit() : super(const AddBookFormState());

  BookObject data = BookObject();
  final ImagePicker _imagePicker = ImagePicker();

  void nameVerify(String name) async {
    if (name == '') {
      emit(const AddBookFormState());
    } else if (!InputVerify.isFolderNameValid(name)) {
      emit(const AddBookFormState(nameStateCode: AddBookNameStateCode.invalid));
    } else if (await BookProcess.isExists(name)) {
      emit(const AddBookFormState(nameStateCode: AddBookNameStateCode.exists));
    } else {
      // Name verification passed.
      data.name = name;
      emit(state.copyWith(nameStateCode: AddBookNameStateCode.valid));
    }
  }

  void pickCoverImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      data.coverFile = null;
      emit(state.copyWith(coverStateCode: AddBookCoverStateCode.blank));
    } else {
      data.coverFile = File(image.path);
      emit(state.copyWith(coverStateCode: AddBookCoverStateCode.valid));
    }
  }
}

class AddBookFormState extends Equatable {
  final AddBookNameStateCode nameStateCode;
  final AddBookCoverStateCode coverStateCode;

  const AddBookFormState({
    this.nameStateCode = AddBookNameStateCode.blank,
    this.coverStateCode = AddBookCoverStateCode.blank,
  });

  AddBookFormState copyWith({
    AddBookNameStateCode? nameStateCode,
    AddBookCoverStateCode? coverStateCode,
  }) {
    return AddBookFormState(
      nameStateCode: nameStateCode ?? this.nameStateCode,
      coverStateCode: coverStateCode ?? this.coverStateCode,
    );
  }

  @override
  List<Object?> get props => [nameStateCode];
}
