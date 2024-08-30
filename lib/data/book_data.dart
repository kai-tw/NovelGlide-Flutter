import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../toolbox/advanced_mime_type_resolver.dart';
import 'chapter_data.dart';
import 'file_path.dart';

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

  /// Get all book data
  static Future<List<BookData>> getDataList() async {
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    return await compute<Map<String, dynamic>, List<BookData>>(_getDataListIsolate, {
      "rootIsolateToken": rootIsolateToken,
      "path": FilePath.instance.libraryRoot,
    });
  }

  static Future<List<BookData>> _getDataListIsolate(Map<String, dynamic> message) async {
    final RootIsolateToken rootIsolateToken = message["rootIsolateToken"];
    final String path = message["path"];

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

    final Directory folder = Directory(path);
    final List<BookData> entries = [];

    for (File epubFile in folder.listSync().whereType<File>()) {
      if (AdvancedMimeTypeResolver.instance.lookupAll(epubFile) == 'application/epub+zip') {
        epub.EpubBook epubBook = await epub.EpubReader.readBook(epubFile.readAsBytesSync());
        entries.add(BookData(epubBook: epubBook, filePath: epubFile.path));
      }
    }

    return entries;
  }

  /// Delete the book
  bool delete() {
    if (file.existsSync()) {
      file.deleteSync();
    }
    return !file.existsSync();
  }
}
