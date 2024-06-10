import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_charset_detector/flutter_charset_detector.dart';

import '../toolbox/chapter_processor.dart';

class ChapterData {
  String bookName;
  int ordinalNumber;
  String? _title;

  ChapterData({
    required this.bookName,
    required this.ordinalNumber,
  });

  String getPath() {
    return ChapterProcessor.getPath(bookName, ordinalNumber);
  }

  Future<String> getTitle() async {
    return await ChapterProcessor.getTitle(bookName, ordinalNumber);
  }

  Future<String> getTitleFromCache({bool isForceUpdate = false}) async {
    if (_title == null || isForceUpdate) {
      _title = await getTitle();
    }
    return _title!;
  }

  Future<List<String>> getContent() async {
    return await ChapterProcessor.getContent(bookName, ordinalNumber);
  }

  bool isExist() {
    return File(getPath()).existsSync();
  }

  Future<bool> create(File file, {String? title}) async {
    Uint8List bytes = await file.readAsBytes();
    DecodingResult result = await CharsetDetector.autoDecode(bytes);
    List<String> contentLines = result.string.split("\n").where((line) => line.isNotEmpty).toList();

    // Create chapter file
    File chapterFile = File(getPath());
    await chapterFile.create();

    // Prepend title
    if (title != null) {
      contentLines.insert(0, title);
    }

    // Write to file
    await chapterFile.writeAsString(contentLines.join("\n"));

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
