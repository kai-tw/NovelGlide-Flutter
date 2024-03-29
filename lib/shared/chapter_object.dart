import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:path/path.dart';

import 'file_path.dart';

class ChapterObject {
  String bookName;
  int ordinalNumber;
  String? _title;

  ChapterObject({
    required this.bookName,
    required this.ordinalNumber,
  });

  String getPath() {
    return join(filePath.libraryRoot, bookName, "$ordinalNumber.txt");
  }

  String getTitle({bool isForce = false}) {
    if (_title == null || isForce) {
      final List<String> content = getContent();
      _title = content.isNotEmpty ? content[0] : "";
    }
    return _title!;
  }

  List<String> getContent() {
    final File file = File(getPath());
    if (!file.existsSync()) {
      return [];
    }
    return file.readAsLinesSync().where((line) => line.isNotEmpty).toList();
  }

  bool isExist() {
    return File(getPath()).existsSync();
  }

  Future<bool> create(File file, {String? title}) async {
    Uint8List bytes = await file.readAsBytes();
    DecodingResult result = await CharsetDetector.autoDecode(bytes);
    String content = result.string;

    // Create chapter file
    File chapterFile = File(getPath());
    await chapterFile.create();

    // Prepend title
    if (title != null) {
      content = "$title\n\n$content";
    }

    // Write to file
    await chapterFile.writeAsString(content);

    return chapterFile.existsSync();
  }

  Future<bool> delete() async {
    final File file = File(getPath());

    if (!file.existsSync()) {
      return false;
    }

    await file.delete();

    return !file.existsSync();
  }
}
