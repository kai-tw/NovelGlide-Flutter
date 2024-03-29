import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:path/path.dart';

import 'file_path.dart';

class ChapterObject {
  String bookName;
  int ordinalNumber;
  String? title;

  ChapterObject({
    required this.bookName,
    required this.ordinalNumber,
  });

  String getPath() {
    return join(filePath.libraryRoot, bookName, "$ordinalNumber.txt");
  }

  Future<void> initAsync() async {
    await refreshTitle(isForce: true);
  }

  Future<void> refreshTitle({bool isForce = false}) async {
    if (title == null || isForce) {
      final Stream<List<int>> inputStream = File(getPath()).openRead();
      final Stream<String> lineStream = inputStream.transform(utf8.decoder).transform(const LineSplitter());
      await for (String line in lineStream) {
        // Get the first not empty line as title.
        String singleLine = line.trim();
        if (singleLine.isNotEmpty) {
          title = singleLine;
          break;
        }
      }
    }
  }

  Future<List<String>> getContent() async {
    final File file = File(getPath());
    if (!file.existsSync()) {
      return [];
    }

    List<String> contentLines = [];
    final Stream<List<int>> inputStream = File(getPath()).openRead();
    final Stream<String> lineStream = inputStream.transform(utf8.decoder).transform(const LineSplitter());

    await for (String line in lineStream) {
      if (line.isNotEmpty) {
        contentLines.add(line);
      }
    }

    return contentLines;
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
