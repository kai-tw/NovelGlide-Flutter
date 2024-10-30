import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../data_model/chapter_data.dart';

class EpubUtils {
  EpubUtils._();

  /// Loads an EpubBook asynchronously, potentially a heavy operation.
  static Future<epub.EpubBook> loadEpubBook(String filePath) async {
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    return await compute<Map<String, dynamic>, epub.EpubBook>(
        _loadEpubBookIsolate, {
      "rootIsolateToken": rootIsolateToken,
      "path": filePath,
    });
  }

  /// Isolate function to load an EpubBook.
  static Future<epub.EpubBook> _loadEpubBookIsolate(
      Map<String, dynamic> message) async {
    final RootIsolateToken rootIsolateToken = message["rootIsolateToken"];
    final String path = message["path"];
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    return await epub.EpubReader.readBook(File(path).readAsBytesSync());
  }

  /// Retrieve the list of chapters from a epub book.
  static Future<List<ChapterData>> getChapterList(String filePath) async {
    final epub.EpubBook epubBook = await EpubUtils.loadEpubBook(filePath);
    return epubBook.Chapters?.map((e) => ChapterData.fromEpubChapter(e))
            .toList() ??
        [];
  }
}
