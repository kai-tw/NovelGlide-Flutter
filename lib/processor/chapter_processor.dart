import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:path/path.dart';

import '../data/chapter_data.dart';
import '../toolbox/chinese_number_parser.dart';
import 'book_processor.dart';
import 'bookmark_processor.dart';
import '../toolbox/chapter_reg_exp.dart';

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
    await for (String line in streamContentFromFile(file)) {
      contentLines.add(line);
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

  static Stream<String> streamContentFromFile(File file) async* {
    Uint8List bytes = await file.readAsBytes();
    DecodingResult result = await CharsetDetector.autoDecode(bytes);
    List<String> lines = result.string.split(Platform.lineTerminator);
    for (String line in lines) {
      line = line.trim();
      if (line.isNotEmpty) {
        yield line;
      }
    }
  }

  /// Create a chapter.
  static Future<bool> create(
    String bookName,
    int ordinalNumber,
    File file, {
    String? title,
    bool isOverwrite = false,
  }) async {
    File? chapterFile = getChapterFileOnCreate(bookName, ordinalNumber, isOverwrite);
    if (chapterFile == null) {
      return false;
    }

    // Prepend title
    if (title != null) {
      chapterFile.writeAsStringSync(title + Platform.lineTerminator, mode: FileMode.append);
    }

    // Write to file
    await for (String line in streamContentFromFile(file)) {
      chapterFile.writeAsStringSync(line + Platform.lineTerminator, mode: FileMode.append);
    }

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
        await ChapterProcessor.create(
          bookName,
          chapterNumber,
          file,
          isOverwrite: isOverwrite,
        );
      }
    }
  }

  /// Import chapters from a txt file.
  /// Use specific sub-string (e.g. Chapter %d) as the delimiter.
  static Future<bool> importFromTxt(String bookName, File file, {bool isOverwrite = false}) async {
    final RegExp regExp = RegExp(ChapterRegExp.chinesePattern.pattern);
    int newChapterNumber = 0;
    int currentChapterNumber = 0;
    File? chapterFile;

    // Todo: Use Isolate to avoid from blocking main thread.
    await for (String line in streamContentFromFile(file)) {
      final Iterable<RegExpMatch> matches = regExp.allMatches(line);

      if (matches.isNotEmpty) {
        /// Find the chapter number!
        newChapterNumber = ChineseNumberParser.parse(matches.first.namedGroup('chapterNumber') ?? "0");

        if (newChapterNumber > 0) {
          if (newChapterNumber != currentChapterNumber) {
            chapterFile = ChapterProcessor.getChapterFileOnCreate(bookName, newChapterNumber, isOverwrite);
          }
        } else {
          chapterFile = null;
        }
        currentChapterNumber = newChapterNumber;

        line = matches.first.namedGroup('title')?.trim() ?? "";
      }

      if (chapterFile != null) {
        chapterFile.writeAsStringSync(line + Platform.lineTerminator, mode: FileMode.append);
      }
    }

    return true;
  }

  static File? getChapterFileOnCreate(String bookName, int ordinalNumber, bool isOverwrite) {
    File chapterFile = File(getPath(bookName, ordinalNumber));
    if (!isOverwrite && chapterFile.existsSync()) {
      return null;
    }
    if (chapterFile.existsSync()) {
      chapterFile.deleteSync();
    }
    chapterFile.createSync();
    return chapterFile;
  }
}
