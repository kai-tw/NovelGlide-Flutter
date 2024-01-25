import 'dart:io';

import 'book_object.dart';

class ChapterObject {
  int ordinalNumber;
  String title;
  final File _file;
  final BookObject _bookObject;

  ChapterObject({
    required this.ordinalNumber,
    required this.title,
    required File file,
    required BookObject bookObject,
  }) : _file = file, _bookObject = bookObject;

  List<String> getLines() {
    if (!_file.existsSync()) {
      return [];
    }
    return _file.readAsLinesSync().where((line) => line.isNotEmpty).toList();
  }

  BookObject getBook() {
    return _bookObject;
  }
}
