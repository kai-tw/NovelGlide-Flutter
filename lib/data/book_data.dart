import 'dart:io';

import 'package:collection/collection.dart';
import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:novelglide/enum/sort_order_code.dart';

import 'bookmark_data.dart';
import 'chapter_data.dart';
import 'collection_data.dart';

/// Represents a book with its metadata and operations.
class BookData {
  final String filePath;
  String name;
  Image? coverImage;

  /// Returns the file object for the book.
  File get file => File(filePath);

  /// Checks if the book file exists.
  bool get isExist => file.existsSync();

  /// Returns the last modified date of the book file.
  DateTime get modifiedDate => file.statSync().modified;

  /// Constructor for creating a BookData instance.
  BookData({required this.filePath, required this.name, this.coverImage});

  /// Factory constructor to create a BookData instance from an EpubBook.
  factory BookData.fromEpubBook(String path, epub.EpubBook epubBook) {
    return BookData(
      filePath: path,
      name: epubBook.Title ?? '',
      coverImage: epubBook.CoverImage,
    );
  }

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

  /// Retrieves a list of chapters from the book.
  Future<List<ChapterData>> getChapterList() async {
    final epub.EpubBook epubBook = await loadEpubBook(filePath);
    return epubBook.Chapters?.map((e) => ChapterData.fromEpubChapter(e, 0))
            .toList() ??
        [];
  }

  /// Finds a chapter by its file name.
  Future<ChapterData?> findChapterByFileName(String fileName) async {
    return _findChapterByFileName(await getChapterList(), fileName);
  }

  /// Helper method to find a chapter by file name recursively.
  ChapterData? _findChapterByFileName(
      List<ChapterData>? chapterList, String fileName) {
    ChapterData? target = chapterList
        ?.firstWhereOrNull((element) => element.fileName == fileName);
    if (target != null) {
      return target;
    }
    for (ChapterData chapter in chapterList ?? []) {
      target ??= _findChapterByFileName(chapter.subChapterList, fileName);
    }
    return target;
  }

  /// Deletes the book and associated bookmarks and collections.
  Future<bool> delete() async {
    if (file.existsSync()) {
      file.deleteSync();
    }

    // Delete associated bookmarks.
    final bookmarkList =
        BookmarkData.getList().where((element) => element.bookPath == filePath);
    await Future.wait(bookmarkList.map((e) => e.delete()));

    // Delete associated collections.
    final collectionList = (await CollectionData.getList())
        .where((element) => element.pathList.contains(filePath));
    for (CollectionData data in collectionList) {
      data.pathList.remove(filePath);
      data.save();
    }

    return !file.existsSync();
  }

  /// Provides a comparison function for sorting books.
  static int Function(BookData, BookData) sortCompare(
      SortOrderCode sortOrder, bool isAscending) {
    switch (sortOrder) {
      case SortOrderCode.modifiedDate:
        return (a, b) => isAscending
            ? a.modifiedDate.compareTo(b.modifiedDate)
            : b.modifiedDate.compareTo(a.modifiedDate);

      default:
        return (a, b) => isAscending
            ? compareNatural(a.name, b.name)
            : compareNatural(b.name, a.name);
    }
  }
}
