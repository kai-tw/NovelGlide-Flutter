import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import '../data/book_data.dart';
import '../data/file_path.dart';
import '../toolbox/advanced_mime_type_resolver.dart';

/// Process all the operation of books.
class BookProcessor {
  static const String coverFileName = 'cover.jpg';

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
        entries.add(BookData.fromEpub(epubBook, epubFile.path));
      }
    }

    return entries;
  }

  /// Get the book path by name
  static String getPathByName(String name) {
    return join(FilePath.instance.libraryRoot, name);
  }

  /// Get the cover path by name
  static String getCoverPathByName(String name) {
    return getCoverPathByBookPath(getPathByName(name));
  }

  /// Get the cover path by book path
  static String getCoverPathByBookPath(String path) {
    return join(path, coverFileName);
  }

  /// Modify folder
  static bool modify(String oldName, String newName) {
    final Directory oldFolder = Directory(getPathByName(oldName));
    final Directory newFolder = Directory(getPathByName(newName));

    if (newName != oldName) {
      oldFolder.renameSync(newFolder.path);
      return newFolder.existsSync();
    }
    return false;
  }

  /// Cover process
  /// Create cover
  static bool createCover(String name, File coverFile) {
    // TODO: Check the mime type and convert it to JPEG
    return coverFile.copySync(getCoverPathByName(name)).existsSync();
  }

  /// Modify cover
  static bool modifyCover(String name, File coverFile) {
    if (coverFile.existsSync()) {
      return createCover(name, coverFile);
    }
    return false;
  }

  /// Import cover
  static void importCover(String name, File coverFile, {bool isOverwrite = false}) {
    if (isOverwrite || !isCoverExist(name)) {
      createCover(name, coverFile);
    }
  }

  /// Delete cover
  static bool deleteCover(String name) {
    final File coverFile = File(getCoverPathByName(name));
    if (coverFile.existsSync()) {
      coverFile.deleteSync();
    }
    return !coverFile.existsSync();
  }

  /// Check if the cover exists
  static bool isCoverExist(String name) {
    return File(getCoverPathByName(name)).existsSync();
  }
}
