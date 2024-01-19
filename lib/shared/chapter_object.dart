import 'dart:io';

class ChapterObject {
  int ordinalNumber;
  String title;
  File file;

  ChapterObject({required this.ordinalNumber, required this.title, required this.file});
}