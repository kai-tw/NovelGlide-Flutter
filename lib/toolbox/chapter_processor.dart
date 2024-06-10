import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../data/chapter_data.dart';
import '../features/common_components/common_file_picker/common_file_picker_type.dart';
import 'book_processor.dart';

/// Process all the operation related to chapters.
class ChapterProcessor {
  static final RegExp _chapterRegexp = RegExp(r'^\d+\.txt$');

  static List<ChapterData> getList(String bookName) {
    final Directory folder = Directory(BookProcessor.getPathByName(bookName));

    if (folder.existsSync()) {
      final List<String> mimeTypes = CommonFilePickerTypeMap.mime[CommonFilePickerType.txt]!;
      final List<String> entries = folder
          .listSync()
          .whereType<File>()
          .where(
              (item) => _chapterRegexp.hasMatch(basename(item.path)) && mimeTypes.contains(lookupMimeType(item.path)))
          .map<String>((item) => item.path)
          .toList();
      entries.sort(compareNatural);

      return entries
          .map((e) => ChapterData(bookName: bookName, ordinalNumber: int.parse(basenameWithoutExtension(e))))
          .toList();
    }

    return [];
  }

  static String getPath(String bookName, int ordinalNumber) {
    return join(BookProcessor.getPathByName(bookName), "$ordinalNumber.txt");
  }

  static Future<List<String>> getContent(String bookName, int ordinalNumber) async {
    final File file = File(getPath(bookName, ordinalNumber));
    if (!file.existsSync()) {
      return [];
    }

    List<String> contentLines = [];
    final Stream<List<int>> inputStream = file.openRead();
    final Stream<String> lineStream = inputStream.transform(utf8.decoder).transform(const LineSplitter());

    await for (String line in lineStream) {
      if (line.isNotEmpty) {
        contentLines.add(line);
      }
    }

    return contentLines;
  }

  static Future<String> getTitle(String bookName, int ordinalNumber) async {
    final File file = File(getPath(bookName, ordinalNumber));
    if (file.existsSync()) {
      final Stream<List<int>> inputStream = file.openRead();
      final Stream<String> lineStream = inputStream.transform(utf8.decoder).transform(const LineSplitter());
      await for (String line in lineStream) {
        // Get the first not empty line as title.
        String singleLine = line.trim();
        if (singleLine.isNotEmpty) {
          return singleLine;
        }
      }
    }
    return "";
  }
}
