import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_file_picker_type.dart';

class CommonFilePickerCubit extends Cubit<CommonFilePickerState> {
  File? file;

  CommonFilePickerCubit({this.file})
      : super(CommonFilePickerState(
          code: file == null ? CommonFilePickerStateCode.blank : CommonFilePickerStateCode.exist,
          file: file,
        ));

  void pickImage() async {
    pickFile(type: CommonFilePickerType.image);
  }

  void pickFile({CommonFilePickerType? type = CommonFilePickerType.any, bool allowMultiple = false, List<String>? allowedExtensions}) async {
    final Map<CommonFilePickerType, FileType> map = {
      CommonFilePickerType.any: FileType.any,
      CommonFilePickerType.image: FileType.image,
      CommonFilePickerType.custom: FileType.custom,
    };

    FilePickerResult? image = await FilePicker.platform.pickFiles(
      type: map[type] ?? FileType.any,
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
