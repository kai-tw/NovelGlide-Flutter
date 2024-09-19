import 'dart:io';

import 'package:collection/collection.dart';
import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:novelglide/data/sort_order_code.dart';

import 'bookmark_data.dart';
import 'chapter_data.dart';
import 'collection_data.dart';

class BookData {
  final String filePath;
  String name;
  Image? coverImage;

  File get file => File(filePath);

  bool get isExist => file.existsSync();

  DateTime get modifiedDate => file.statSync().modified;

  BookData({required this.filePath, required this.name, this.coverImage});

  factory BookData.fromEpubBook(String path, epub.EpubBook epubBook) {
    return BookData(
      filePath: path,
      name: epubBook.Title ?? '',
      coverImage: epubBook.CoverImage,
    );
  }

  /// If the book is large, it will be an intensive task to read the whole book.
  static Future<epub.EpubBook> loadEpubBook(String filePath) async {
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    return await compute<Map<String, dynamic>, epub.EpubBook>(_loadEpubBookIsolate, {
      "rootIsolateToken": rootIsolateToken,
      "path": filePath,
    });
  }

  static Future<epub.EpubBook> _loadEpubBookIsolate(Map<String, dynamic> message) async {
    final RootIsolateToken rootIsolateToken = message["rootIsolateToken"];
    final String path = message["path"];
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    return await epub.EpubReader.readBook(File(path).readAsBytesSync());
  }

  Future<List<ChapterData>> getChapterList() async {
    final epub.EpubBook epubBook = await loadEpubBook(filePath);
    return epubBook.Chapters?.map((e) => ChapterData.fromEpubChapter(e, 0)).toList() ?? [];
  }

  Future<ChapterData?> findChapterByFileName(String fileName) async {
    return _findChapterByFileName(await getChapterList(), fileName);
  }

  ChapterData? _findChapterByFileName(List<ChapterData>? chapterList, String fileName) {
    ChapterData? target = chapterList?.firstWhereOrNull((element) => element.fileName == fileName);
    if (target != null) {
      return target;
    }
    for (ChapterData chapter in chapterList ?? []) {
      target ??= _findChapterByFileName(chapter.subChapterList, fileName);
    }
    return target;
  }

  /// Delete the book
  Future<bool> delete() async {
    if (file.existsSync()) {
      file.deleteSync();
    }

    /// Search the bookmark and delete it.
    Iterable<BookmarkData> bookmarkList = (await BookmarkData.getList()).where((element) => element.bookPath == filePath);
    for (BookmarkData data in bookmarkList) {
      data.delete();
    }

    /// Search the collection and delete it.
    Iterable<CollectionData> collectionList =
        (await CollectionData.getList()).where((element) => element.pathList.contains(filePath));
    for (CollectionData data in collectionList) {
      data.pathList.remove(filePath);
      data.save();
    }

    return !file.existsSync();
  }

  static int Function(BookData, BookData) sortCompare(SortOrderCode sortOrder, bool isAscending) {
    switch (sortOrder) {
      case SortOrderCode.modifiedDate:
        return (a, b) => isAscending ? a.modifiedDate.compareTo(b.modifiedDate) : b.modifiedDate.compareTo(a.modifiedDate);

      default:
        return (a, b) => isAscending ? compareNatural(a.name, b.name) : compareNatural(b.name, a.name);
    }
  }
}
