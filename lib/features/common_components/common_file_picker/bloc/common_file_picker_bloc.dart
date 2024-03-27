import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_file_picker_type.dart';

class CommonFilePickerCubit extends Cubit<CommonFilePickerState> {
  File? file;

  CommonFilePickerCubit({this.file}) : super(CommonFilePickerState(file: file));

  void pickImage() async {
    pickFile(type: CommonFilePickerType.image);
  }

  void pickFile(
      {CommonFilePickerType? type = CommonFilePickerType.any,
      bool allowMultiple = false,
      List<String>? allowedExtensions}) async {
    final Map<CommonFilePickerType, FileType> map = {
      CommonFilePickerType.any: FileType.any,
      CommonFilePickerType.image: FileType.image,
      CommonFilePickerType.custom: FileType.custom,
    };

    FilePickerResult? f = await FilePicker.platform
        .pickFiles(type: map[type] ?? FileType.any, allowMultiple: allowMultiple, allowedExtensions: allowedExtensions);

    if (f == null) {
      removeFile();
    } else {
      file = File(f.files.single.path!);
      emit(CommonFilePickerState(file: file));
    }
  }

  void removeFile() {
    file = null;
    emit(CommonFilePickerState());
  }
}

class CommonFilePickerState extends Equatable {
  final CommonFilePickerStateCode code;
  final File? file;

  @override
  List<Object?> get props => [code, file];

  CommonFilePickerState({this.file})
      : code = file != null && file.existsSync() ? CommonFilePickerStateCode.exist : CommonFilePickerStateCode.blank;
}

enum CommonFilePickerStateCode { blank, exist }
