import 'dart:io';

import 'package:path/path.dart';

import 'file_path.dart';

class ChapterObject {
  final String bookName;
  final int ordinalNumber;

  const ChapterObject({
    required this.bookName,
    required this.ordinalNumber,
  });

  String getPath() {
    return join(filePath.libraryRoot, bookName, "$ordinalNumber.txt");
  }

  String getTitle() {
    final List<String> content = getContent();
    if (content.isNotEmpty) {
      return content[0];
    }
    return '';
  }

  List<String> getContent() {
    final File file = File(getPath());
    if (!file.existsSync()) {
      return [];
    }
    return file.readAsLinesSync().where((line) => line.isNotEmpty).toList();
  }
}
