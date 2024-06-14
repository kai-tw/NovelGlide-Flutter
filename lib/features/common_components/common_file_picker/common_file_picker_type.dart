import 'package:file_picker/file_picker.dart';

enum CommonFilePickerType {
  any,
  image,
  txt,
  archive,
  custom,
}

class CommonFilePickerTypeMap {
  static final Map<CommonFilePickerType, List<String>> extension = {
    CommonFilePickerType.archive: ['zip'],
    CommonFilePickerType.txt: ['txt'],
  };

  static final Map<CommonFilePickerType, List<String>> mime = {
    CommonFilePickerType.image: ['image/jpeg', 'image/png', 'image/gif'],
    CommonFilePickerType.archive: ['application/zip'],
    CommonFilePickerType.txt: ['text/plain'],
  };

  static final Map<CommonFilePickerType, FileType> fileTypeMap = {
    CommonFilePickerType.any: FileType.any,
    CommonFilePickerType.image: FileType.image,
    CommonFilePickerType.txt: FileType.custom,
    CommonFilePickerType.archive: FileType.custom,
    CommonFilePickerType.custom: FileType.custom,
  };
}