import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CommonImagePickerCubit extends Cubit<CommonImagePickerState> {
  final ImagePicker _imagePicker = ImagePicker();
  File? imageFile;

  CommonImagePickerCubit({this.imageFile})
      : super(CommonImagePickerState(
          code: imageFile == null ? CommonImagePickerCubitStateCode.blank : CommonImagePickerCubitStateCode.exist,
          imageFile: imageFile,
        ));

  void pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      removeImage();
    } else {
      emit(CommonImagePickerState(code: CommonImagePickerCubitStateCode.exist, imageFile: File(image.path)));
    }
  }

  void removeImage() {
    emit(const CommonImagePickerState(code: CommonImagePickerCubitStateCode.blank));
  }
}

class CommonImagePickerState extends Equatable {
  final CommonImagePickerCubitStateCode code;
  final File? imageFile;

  const CommonImagePickerState({required this.code, this.imageFile});

  CommonImagePickerState copyWith({CommonImagePickerCubitStateCode? code, File? imageFile}) {
    return CommonImagePickerState(code: code ?? this.code, imageFile: imageFile ?? this.imageFile);
  }

  @override
  List<Object?> get props => [code, imageFile];
}

enum CommonImagePickerCubitStateCode { blank, exist }
