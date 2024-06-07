import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_file_picker_type.dart';

class CommonFilePickerCubit extends Cubit<CommonFilePickerState> {
  File? file;

  CommonFilePickerCubit({this.file}) : super(CommonFilePickerState.fromFile(file));

  void pickImage() async {
    pickFile(type: CommonFilePickerType.image);
  }

  void pickFile({
    CommonFilePickerType? type = CommonFilePickerType.any,
    bool allowMultiple = false,
    List<String>? allowedExtensions,
  }) async {
    final Map<CommonFilePickerType, FileType> map = {
      CommonFilePickerType.any: FileType.any,
      CommonFilePickerType.image: FileType.image,
      CommonFilePickerType.txt: FileType.custom,
      CommonFilePickerType.archive: FileType.custom,
      CommonFilePickerType.custom: FileType.custom,
    };

    allowedExtensions = (allowedExtensions ?? []) + (CommonFilePickerTypeMap.extension[type] ?? []);

    FilePickerResult? f = await FilePicker.platform.pickFiles(
      type: map[type] ?? FileType.any,
      allowMultiple: allowMultiple,
      allowedExtensions: allowedExtensions,
    );

    if (f == null) {
      removeFile();
    } else {
      file = File(f.files.single.path!);
    }
    validator();
  }

  void removeFile() {
    file = null;
  }

  void validator() {
    emit(state.changeFile(file));
  }
}

class CommonFilePickerState extends Equatable {
  final CommonFilePickerStateCode code;
  final File? file;

  @override
  List<Object?> get props => [code, file];

  const CommonFilePickerState({this.code = CommonFilePickerStateCode.initial, this.file});

  factory CommonFilePickerState.fromFile(File? f) {
    CommonFilePickerStateCode c =
        f != null && f.existsSync() ? CommonFilePickerStateCode.exist : CommonFilePickerStateCode.initial;
    return CommonFilePickerState(code: c, file: f);
  }

  CommonFilePickerState changeFile(File? f) {
    CommonFilePickerStateCode c =
        f != null && f.existsSync() ? CommonFilePickerStateCode.exist : CommonFilePickerStateCode.blank;
    return CommonFilePickerState(code: c, file: f);
  }
}

enum CommonFilePickerStateCode { initial, blank, exist }
