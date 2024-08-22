import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'chapter_data.dart';

class BookData {
  String filePath;
  epub.EpubBook epubBook;

  File get file => File(filePath);

  bool get isExist => file.existsSync();

  DateTime get modifiedDate => file.statSync().modified;

  String get name => epubBook.Title ?? '';

  Uint8List? get coverBytes => epubBook.CoverImage?.getBytes();

  List<ChapterData>? get chapterList {
    List<ChapterData> chapterList = [];

    for (int i = 0; i < (epubBook.Chapters ?? []).length; i++) {
      epub.EpubChapter epubChapter = epubBook.Chapters![i];
      chapterList.add(ChapterData.fromEpubChapter(epubChapter, i + 1));
    }

    return chapterList;
  }

  BookData({required this.filePath, required this.epubBook});

  static Future<BookData> fromPath(String path) async {
    return BookData(
      filePath: path,
      epubBook: await epub.EpubReader.readBook(File(path).readAsBytesSync()),
    );
  }

  /// Delete the book
  bool delete() {
    if (file.existsSync()) {
      file.deleteSync();
    }
    return !file.existsSync();
  }
}
