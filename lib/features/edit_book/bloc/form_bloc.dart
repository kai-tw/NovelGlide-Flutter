import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/book_process.dart';
import '../../../shared/input_verify.dart';

enum EditBookNameStateCode { valid, blank, invalid, exists, same }

enum EditBookCoverStateCode { blank, valid, same }

class EditBookFormCubit extends Cubit<EditBookFormState> {
  EditBookFormCubit(this.data) : super(const EditBookFormState()) {
    oldName = nameValue = data.name;
  }

  BookObject data;
  late String oldName;
  late String nameValue;
  final ImagePicker _imagePicker = ImagePicker();

  void nameVerify(String name) async {
    nameValue = name;
    if (name == '') {
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.blank));
    } else if (!InputVerify.isFolderNameValid(name)) {
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.invalid));
    } else if (await BookProcess.isExists(name)) {
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.exists));
    } else {
      data.name = name;
      emit(state.copyWith(nameStateCode: EditBookNameStateCode.valid));
    }
  }

  void pickCoverImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      data.coverFile = null;
      emit(state.copyWith(coverStateCode: EditBookCoverStateCode.blank));
    } else {
      data.coverFile = File(image.path);
      emit(state.copyWith(coverStateCode: EditBookCoverStateCode.valid));
    }
  }

  void removeCoverImage() {
    data.coverFile = null;
    emit(state.copyWith(coverStateCode: EditBookCoverStateCode.blank));
  }

  Future<bool> submit() async {
    return await data.rename(oldName);
  }
}

class EditBookFormState extends Equatable {
  final EditBookNameStateCode nameStateCode;
  final EditBookCoverStateCode coverStateCode;

  const EditBookFormState({
    this.nameStateCode = EditBookNameStateCode.same,
    this.coverStateCode = EditBookCoverStateCode.same,
  });

  EditBookFormState copyWith({
    EditBookNameStateCode? nameStateCode,
    EditBookCoverStateCode? coverStateCode,
  }) {
    return EditBookFormState(
      nameStateCode: nameStateCode ?? this.nameStateCode,
      coverStateCode: coverStateCode ?? this.coverStateCode,
    );
  }

  @override
  List<Object?> get props => [nameStateCode, coverStateCode];
}
