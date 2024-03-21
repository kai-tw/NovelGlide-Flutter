import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonFilePickerCubit extends Cubit<CommonFilePickerState> {
  File? file;

  CommonFilePickerCubit({this.file})
      : super(CommonFilePickerState(
          code: file == null ? CommonFilePickerStateCode.blank : CommonFilePickerStateCode.exist,
          file: file,
        ));

  void pickImage() async {
    pickFile(FileType.image);
  }

  void pickFile(FileType type, {bool allowMultiple = false, List<String>? allowedExtensions}) async {
    FilePickerResult? image = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: allowMultiple,
      allowedExtensions: allowedExtensions
    );

    if (image == null) {
      removeFile();
    } else {
      file = File(image.files.single.path!);
      emit(CommonFilePickerState(code: CommonFilePickerStateCode.exist, file: file));
    }
  }

  void removeFile() {
    file = null;
    emit(const CommonFilePickerState(code: CommonFilePickerStateCode.blank));
  }
}

class CommonFilePickerState extends Equatable {
  final CommonFilePickerStateCode code;
  final File? file;

  const CommonFilePickerState({required this.code, this.file});

  CommonFilePickerState copyWith({CommonFilePickerStateCode? code, File? file}) {
    return CommonFilePickerState(code: code ?? this.code, file: file ?? this.file);
  }

  @override
  List<Object?> get props => [code, file];
}

enum CommonFilePickerStateCode { blank, exist }
