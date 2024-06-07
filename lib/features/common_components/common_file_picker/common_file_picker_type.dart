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
    CommonFilePickerType.archive: ['application/zip'],
    CommonFilePickerType.txt: ['text/plain'],
  };
}