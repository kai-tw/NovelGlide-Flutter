import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../../../../data/file_path.dart';
import '../../../../toolbox/advanced_mime_type_resolver.dart';
import '../common_file_picker_type.dart';

class CommonFilePickerCubit extends Cubit<CommonFilePickerState> {
  File? file;
  CommonFilePickerType type = CommonFilePickerType.any;

  CommonFilePickerCubit({this.file}) : super(CommonFilePickerState.fromFile(file));

  bool _hasMimeMatch() {
    final RandomAccessFile openFile = file!.openSync(mode: FileMode.read);
    final List<int> headerBytes = List.generate(AdvancedMimeTypeResolver().magicNumbersMaxLength, (_) => 0);

    openFile.readIntoSync(headerBytes, 0, AdvancedMimeTypeResolver().magicNumbersMaxLength);
    final String? mimeType = AdvancedMimeTypeResolver().lookup("", headerBytes: headerBytes);
    openFile.closeSync();

    return type == CommonFilePickerType.any ||
        CommonFilePickerTypeMap.mime[type] != null && CommonFilePickerTypeMap.mime[type]!.contains(mimeType);
  }

  void pickImage() async {
    pickFile(type: CommonFilePickerType.image);
  }

  void pickFile({
    CommonFilePickerType? type = CommonFilePickerType.any,
    bool allowMultiple = false,
    List<String>? allowedExtensions,
  }) async {
    this.type = type!;
    allowedExtensions = (allowedExtensions ?? []) + (CommonFilePickerTypeMap.extension[this.type] ?? []);

    FilePickerResult? f = await FilePicker.platform.pickFiles(
      type: CommonFilePickerTypeMap.fileTypeMap[this.type] ?? FileType.any,
      allowMultiple: allowMultiple,
      allowedExtensions: allowedExtensions,
    );

    file = f != null ? File(f.files.single.path!) : null;
    emit(state.changeFile(file));
  }

  void removeFile() {
    file = null;
    emit(state.changeFile(file));
  }

  bool validator() {
    CommonFilePickerStateCode code = CommonFilePickerStateCode.blank;
    if (file == null) {
      code = CommonFilePickerStateCode.blank;
    } else if (!_hasMimeMatch()) {
      code = CommonFilePickerStateCode.illegalType;
    } else {
      code = CommonFilePickerStateCode.exist;
    }

    emit(CommonFilePickerState(code: code, file: file));
    return code != CommonFilePickerStateCode.exist;
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

enum CommonFilePickerStateCode { initial, blank, exist, illegalType }
