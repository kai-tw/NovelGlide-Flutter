import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';

import '../toolbox/advanced_mime_type_resolver.dart';
import 'bookmark_data.dart';
import 'chapter_data.dart';
import 'collection_data.dart';
import 'file_path.dart';

class BookData {
  final String filePath;
  String name;
  Image? coverImage;
  List<ChapterData>? chapterList;

  File get file => File(filePath);

  bool get isExist => file.existsSync();

  DateTime get modifiedDate => file.statSync().modified;

  BookData({required this.filePath, required this.name, this.coverImage, this.chapterList});

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
      entries.add(await _loadEpubBook(epubFile.path));
    }

    return entries;
  }

  static Future<BookData> loadEpubBook(String filePath) async {
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    return await compute<Map<String, dynamic>, BookData>(_loadEpubBookIsolate, {
      "rootIsolateToken": rootIsolateToken,
      "path": filePath,
    });
  }

  static Future<BookData> _loadEpubBookIsolate(Map<String, dynamic> message) async {
    final RootIsolateToken rootIsolateToken = message["rootIsolateToken"];
    final String path = message["path"];
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    return _loadEpubBook(path);
  }

  static Future<BookData> _loadEpubBook(String path) async {
    epub.EpubBook? epubBook;
    epubBook = await epub.EpubReader.readBook(File(path).readAsBytesSync());
    String name = epubBook.Title ?? '';
    Image? coverImage = epubBook.CoverImage;
    List<ChapterData> chapterList = [];

    for (int i = 0; i < epubBook.Chapters!.length; i++) {
      chapterList.add(ChapterData.fromEpubChapter(epubBook.Chapters![i], i));
    }

    epubBook = null;
    return BookData(filePath: path, name: name, coverImage: coverImage, chapterList: chapterList);
  }

  /// Delete the book
  bool delete() {
    if (file.existsSync()) {
      file.deleteSync();
    }

    /// Search the bookmark and delete it.
    Iterable<BookmarkData> bookmarkList = BookmarkData.getList().where((element) => element.bookPath == filePath);
    for (BookmarkData data in bookmarkList) {
      data.delete();
    }

    /// Search the collection and delete it.
    Iterable<CollectionData> collectionList =
        CollectionData.getList().where((element) => element.pathList.contains(filePath));
    for (CollectionData data in collectionList) {
      data.pathList.remove(filePath);
      data.save();
    }

    return !file.existsSync();
  }
}
