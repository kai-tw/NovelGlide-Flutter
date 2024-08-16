import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:path/path.dart';

import '../data/chapter_data.dart';
import '../data/file_path.dart';
import '../toolbox/chinese_number_parser.dart';
import '../toolbox/chapter_reg_exp.dart';
import 'book_processor.dart';
import 'bookmark_processor.dart';
import 'chapter_processor_exception.dart';

/// Process all the operation related to chapters.
class ChapterProcessor {
  static final RegExp chapterRegexp = RegExp(r'^Chapter\.\d+\.md$');

  /// Get the chapter file name.
  static String getFileName(int ordinalNumber) {
    return "Chapter.$ordinalNumber.md";
  }

  /// Get the path of a chapter.
  static String getPath(String bookName, int ordinalNumber) {
    return join(BookProcessor.getPathByName(bookName), getFileName(ordinalNumber));
  }

  /// Get the ordinal number of a chapter from its file name.
  static int getOrdinalNumberFromPath(String path) {
    return int.parse(basenameWithoutExtension(path).replaceAll("Chapter.", ""));
  }

  /// Get all the chapter data of a book.
  static Future<List<ChapterData>> getList(String bookName) async {
    final Directory folder = Directory(BookProcessor.getPathByName(bookName));

    if (!folder.existsSync()) {
      return [];
    }

    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    return await compute<Map<String, dynamic>, List<ChapterData>>(_getListIsolate, {
      "rootIsolateToken": rootIsolateToken,
      "bookName": bookName,
      "folder": folder,
    });
  }

  static Future<List<ChapterData>> _getListIsolate(Map<String, dynamic> message) async {
    final RootIsolateToken rootIsolateToken = message["rootIsolateToken"];
    final String bookName = message["bookName"];
    final Directory folder = message["folder"];

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

    List<ChapterData> chapterList = [];
    await for (FileSystemEntity entity in folder.list()) {
      if (entity is File && chapterRegexp.hasMatch(basename(entity.path))) {
        int ordinalNumber = getOrdinalNumberFromPath(entity.path);
        String title = await ChapterProcessor.getTitle(folder, ordinalNumber);
        chapterList.add(ChapterData(bookName: bookName, ordinalNumber: ordinalNumber, title: title));
      }
    }
    chapterList.sort((a, b) => a.ordinalNumber - b.ordinalNumber);
    return chapterList;
  }

  /// Is the chapter exist.
  static bool isExist(String bookName, int ordinalNumber) {
    return File(getPath(bookName, ordinalNumber)).existsSync();
  }

  static Future<List<String>> getContent(String bookName, int ordinalNumber, {bool isAutoDecode = true}) async {
    final File file = File(getPath(bookName, ordinalNumber));
    if (!file.existsSync()) {
      return [];
    }
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    return await compute<Map<String, dynamic>, List<String>>(_getContentIsolate, {
      "rootIsolateToken": rootIsolateToken,
      "file": file,
      "isAutoDecode": isAutoDecode,
    });
  }

  static Future<List<String>> _getContentIsolate(Map<String, dynamic> message) async {
    final RootIsolateToken rootIsolateToken = message["rootIsolateToken"];
    final File file = message["file"];
    final bool isAutoDecode = message["isAutoDecode"];
    List<String> contentLines = [];

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

    await for (String line in _streamContentFromFile(file, isAutoDecode: isAutoDecode)) {
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
  static Future<String> getTitle(Directory bookFolder, int ordinalNumber) async {
    final File file = File(join(bookFolder.path, getFileName(ordinalNumber)));
    if (file.existsSync()) {
      final Stream<List<int>> inputStream = file.openRead();
      final Stream<String> lineStream = inputStream.transform(utf8.decoder).transform(const LineSplitter());
      await for (String line in lineStream) {
        // Get the first non-empty line as title.
        return line;
      }
    }
    return "";
  }

  static Stream<String> _streamContentFromFile(File file, {bool isAutoDecode = true}) async* {
    if (isAutoDecode) {
      Uint8List bytes = await file.readAsBytes();
      DecodingResult result = await CharsetDetector.autoDecode(bytes);
      List<String> lines = result.string.split(Platform.lineTerminator);
      for (String line in lines) {
        line = line.trim();
        if (line.isNotEmpty) {
          yield line;
        }
      }
    } else {
      Stream<String> inputStream = file.openRead().transform(utf8.decoder).transform(const LineSplitter());
      await for (String line in inputStream) {
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
    File chapterFile = File(getPath(bookName, ordinalNumber));
    if (!isOverwrite && chapterFile.existsSync()) {
      throw ChapterProcessorDuplicateException(ordinalNumber);
    }

    if (chapterFile.existsSync()) {
      chapterFile.deleteSync();
    }
    chapterFile.createSync();

    // Prepend title
    if (title != null) {
      chapterFile.writeAsStringSync(title + Platform.lineTerminator, mode: FileMode.append);
    }

    // Write to file
    await for (String line in _streamContentFromFile(file)) {
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
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    final String libraryRoot = FilePath.instance.libraryRoot;

    return await compute<Map<String, dynamic>, bool>(_importFromTxtIsolate, {
      "rootIsolateToken": rootIsolateToken,
      "libraryRoot": libraryRoot,
      "bookName": bookName,
      "file": file,
      "isOverwrite": isOverwrite,
    });
  }

  static Future<bool> _importFromTxtIsolate(Map<String, dynamic> message) async {
    final RootIsolateToken rootIsolateToken = message["rootIsolateToken"];
    final String libraryRoot = message["libraryRoot"];
    final String bookName = message["bookName"];
    final File file = message["file"];
    final bool isOverwrite = message["isOverwrite"];

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

    final RegExp regExp = RegExp(ChapterRegExp.chinesePattern.pattern);
    int newChapterNumber = 0;
    int currentChapterNumber = 0;
    File? chapterFile;

    await for (String line in _streamContentFromFile(file)) {
      final Iterable<RegExpMatch> matches = regExp.allMatches(line);

      if (matches.isNotEmpty) {
        /// Find the chapter number!
        newChapterNumber = ChineseNumberParser.parse(matches.first.namedGroup('chapterNumber') ?? "0");

        if (newChapterNumber > 0) {
          if (newChapterNumber != currentChapterNumber) {
            chapterFile = File(join(libraryRoot, bookName, getFileName(newChapterNumber)));

            if (!isOverwrite && chapterFile.existsSync()) {
              throw ChapterProcessorDuplicateException(newChapterNumber);
            }

            if (chapterFile.existsSync()) {
              chapterFile.deleteSync();
            }

            chapterFile.createSync();
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
}
