import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';

import '../toolbox/advanced_mime_type_resolver.dart';
import 'bookmark_data.dart';
import 'chapter_data.dart';
import 'collection_data.dart';
import 'file_path.dart';

class BookData extends Equatable {
  final String filePath;
  final epub.EpubBook epubBook;

  File get file => File(filePath);

  bool get isExist => file.existsSync();

  DateTime get modifiedDate => file.statSync().modified;

  String get name => epubBook.Title ?? '';

  Image? get coverImage => epubBook.CoverImage;

  List<ChapterData>? get chapterList {
    List<ChapterData> chapterList = [];

    for (int i = 0; i < (epubBook.Chapters ?? []).length; i++) {
      epub.EpubChapter epubChapter = epubBook.Chapters![i];
      chapterList.add(ChapterData.fromEpubChapter(epubChapter, i + 1));
    }

    return chapterList;
  }

  @override
  List<Object?> get props => [filePath];

  const BookData({required this.filePath, required this.epubBook});

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

    /// Search the bookmark and delete it.
    Iterable<BookmarkData> bookmarkList = BookmarkData.getList().where((element) => element.bookPath == filePath);
    for (BookmarkData data in bookmarkList) {
      data.delete();
    }

    /// Search the collection and delete it.
    Iterable<CollectionData> collectionList = CollectionData.getList().where((element) => element.pathList.contains(filePath));
    for (CollectionData data in collectionList) {
      data.pathList.remove(filePath);
      data.save();
    }

    return !file.existsSync();
  }
}
