import 'dart:io';

class ChapterObject {
  int ordinalNumber;
  String title;
  File file;

  ChapterObject({required this.ordinalNumber, required this.title, required this.file});

  List<String> getLines() {
    if (!file.existsSync()) {
      return [];
    }
    return file.readAsLinesSync().where((line) => line.isNotEmpty).toList();
  }
}