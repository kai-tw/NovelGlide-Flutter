import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonImagePickerCubit extends Cubit<CommonImagePickerState> {
  File? imageFile;

  CommonImagePickerCubit({this.imageFile})
      : super(CommonImagePickerState(
          code: imageFile == null ? CommonImagePickerCubitStateCode.blank : CommonImagePickerCubitStateCode.exist,
          imageFile: imageFile,
        ));

  void pickImage() async {
    FilePickerResult? image = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (image == null) {
      removeImage();
    } else {
      imageFile = File(image.files.single.path!);
      emit(CommonImagePickerState(code: CommonImagePickerCubitStateCode.exist, imageFile: imageFile));
    }
  }

  void removeImage() {
    imageFile = null;
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
