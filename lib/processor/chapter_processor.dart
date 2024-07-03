import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:path/path.dart';

import '../data/chapter_data.dart';
import '../features/common_components/common_file_picker/common_file_picker_type.dart';
import '../toolbox/advanced_mime_type_resolver.dart';
import 'book_processor.dart';

/// Process all the operation related to chapters.
class ChapterProcessor {
  static final RegExp chapterRegexp = RegExp(r'^\d+\.txt$');

  /// Get all the chapter data of a book.
  static List<ChapterData> getList(String bookName) {
    final Directory folder = Directory(BookProcessor.getPathByName(bookName));

    if (folder.existsSync()) {
      final List<String> mimeTypes = CommonFilePickerTypeMap.mime[CommonFilePickerType.txt]!;
      final List<String> entries = folder
          .listSync()
          .whereType<File>()
          .where((item) =>
              chapterRegexp.hasMatch(basename(item.path)) &&
              mimeTypes.contains(AdvancedMimeTypeResolver().lookupAll(item)))
          .map<String>((item) => item.path)
          .toList();
      entries.sort(compareNatural);

      return entries
          .map((e) => ChapterData(bookName: bookName, ordinalNumber: int.parse(basenameWithoutExtension(e))))
          .toList();
    }

    return [];
  }

  /// Get the path of a chapter.
  static String getPath(String bookName, int ordinalNumber) {
    return join(BookProcessor.getPathByName(bookName), "$ordinalNumber.txt");
  }

  /// Is the chapter exist.
  static bool isExist(String bookName, int ordinalNumber) {
    return File(getPath(bookName, ordinalNumber)).existsSync();
  }

  /// Get the content of a chapter.
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

  /// Get the previous chapter number.
  static int getPrevChapterNumber(String bookName, int chapterNumber) {
    final List<ChapterData> chapterList = getList(bookName);
    int currentIndex = chapterList.indexWhere((obj) => obj.ordinalNumber == chapterNumber);
    if (currentIndex > 0) {
      return chapterList[currentIndex - 1].ordinalNumber;
    }
    return -1;
  }

  /// Get the next chapter number.
  static int getNextChapterNumber(String bookName, int chapterNumber) {
    final List<ChapterData> chapterList = getList(bookName);
    int currentIndex = chapterList.indexWhere((obj) => obj.ordinalNumber == chapterNumber);
    if (0 <= currentIndex && currentIndex < chapterList.length - 1) {
      return chapterList[currentIndex + 1].ordinalNumber;
    }
    return -1;
  }

  /// Get the title of a chapter.
  static Future<String> getTitle(String bookName, int ordinalNumber) async {
    final File file = File(getPath(bookName, ordinalNumber));
    if (file.existsSync()) {
      final Stream<List<int>> inputStream = file.openRead();
      final Stream<String> lineStream = inputStream.transform(utf8.decoder).transform(const LineSplitter());
      await for (String line in lineStream) {
        // Get the first non-empty line as title.
        String singleLine = line.trim();
        if (singleLine.isNotEmpty) {
          return singleLine;
        }
      }
    }
    return "";
  }

  /// Create a chapter.
  static Future<bool> create(String bookName, int ordinalNumber, File file, {String? title}) async {
    Uint8List bytes = await file.readAsBytes();
    DecodingResult result = await CharsetDetector.autoDecode(bytes);
    List<String> contentLines = result.string.split(Platform.lineTerminator).where((line) => line.isNotEmpty).toList();

    // Create chapter file
    File chapterFile = File(getPath(bookName, ordinalNumber));
    chapterFile.createSync();

    // Prepend title
    if (title != null) {
      contentLines.insert(0, title);
    }

    // Write to file
    chapterFile.writeAsStringSync(contentLines.join(Platform.lineTerminator));

    return chapterFile.existsSync();
  }

  /// Delete a chapter.
  static Future<bool> delete(String bookName, int ordinalNumber) async {
    final File file = File(getPath(bookName, ordinalNumber));
    if (file.existsSync()) {
      file.deleteSync();
      return !file.existsSync();
    }
    return false;
  }

  /// Import chapters from a list of files.
  static Future<void> import(String bookName, List<File> chapterFiles, {bool isOverwrite = false}) async {
    for (File file in chapterFiles) {
      final String fileName = basename(file.path);
      final int chapterNumber = int.parse(basenameWithoutExtension(fileName));

      if (isOverwrite || !ChapterProcessor.isExist(bookName, chapterNumber)) {
        await ChapterProcessor.create(bookName, chapterNumber, file);
      }
    }
  }
}
