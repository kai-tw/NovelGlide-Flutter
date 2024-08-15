import 'package:file_picker/file_picker.dart';

enum CommonFilePickerType {
  any(FileType.any),
  image(FileType.image),
  txt(FileType.custom, extensions: ['txt'], mimeTypes: ['text/plain']),
  zip(FileType.custom, extensions: ['zip'], mimeTypes: ['application/zip']),
  epub(FileType.custom, extensions: ['epub'], mimeTypes: ['application/epub+zip']),
  custom(FileType.custom);

  final List<String>? extensions;
  final List<String>? mimeTypes;
  final FileType fileType;
  const CommonFilePickerType(this.fileType, {this.extensions, this.mimeTypes});
}