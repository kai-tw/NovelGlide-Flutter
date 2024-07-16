import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:path/path.dart';

import '../data/chapter_data.dart';
import 'book_processor.dart';
import 'bookmark_processor.dart';

/// Process all the operation related to chapters.
class ChapterProcessor {
  static final RegExp chapterRegexp = RegExp(r'^Chapter\.\d+\.txt$');

  /// Get the path of a chapter.
  static String getPath(String bookName, int ordinalNumber) {
    return join(BookProcessor.getPathByName(bookName), "Chapter.$ordinalNumber.txt");
  }

  /// Get the ordinal number of a chapter from its file name.
  static int getOrdinalNumberFromPath(String path) {
    return int.parse(basenameWithoutExtension(path).replaceAll("Chapter.", ""));
  }

  /// Get all the chapter data of a book.
  static Future<List<ChapterData>> getList(String bookName) async {
    final Directory folder = Directory(BookProcessor.getPathByName(bookName));
    List<ChapterData> chapterList = [];

    if (await folder.exists()) {
      await for (FileSystemEntity entity in folder.list()) {
        if (entity is File && chapterRegexp.hasMatch(basename(entity.path))) {
          chapterList.add(ChapterData(bookName: bookName, ordinalNumber: getOrdinalNumberFromPath(entity.path)));
        }
      }

      chapterList.sort((a, b) => a.ordinalNumber - b.ordinalNumber);

      return chapterList;
    }

    return [];
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
  static Future<int> getPrevChapterNumber(String bookName, int chapterNumber) async {
    final List<ChapterData> chapterList = await getList(bookName);
    int currentIndex = chapterList.indexWhere((obj) => obj.ordinalNumber == chapterNumber);
    if (currentIndex > 0) {
      return chapterList[currentIndex - 1].ordinalNumber;
    }
    return -1;
  }

  /// Get the next chapter number.
  static Future<int> getNextChapterNumber(String bookName, int chapterNumber) async {
    final List<ChapterData> chapterList = await getList(bookName);
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

    BookmarkProcessor.chapterCreateCheck(bookName, ordinalNumber);

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

  /// Import chapters from a folder.
  static Future<void> importFromFolder(String bookName, Directory folder, {bool isOverwrite = false}) async {
    final List<File> chapterFiles = folder
        .listSync()
        .whereType<File>()
        .where((file) => ChapterProcessor.chapterRegexp.hasMatch(basename(file.path)))
        .toList();

    for (File file in chapterFiles) {
      final int chapterNumber = getOrdinalNumberFromPath(file.path);

      if (isOverwrite || !ChapterProcessor.isExist(bookName, chapterNumber)) {
        await ChapterProcessor.create(bookName, chapterNumber, file);
      }
    }
  }
}
