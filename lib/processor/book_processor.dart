import 'dart:io';

import 'package:collection/collection.dart';
import 'package:epubx/epubx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path/path.dart';

import '../data/book_data.dart';
import '../data/file_path.dart';
import '../data/zip_encoding.dart';
import '../toolbox/random_utility.dart';
import 'chapter_processor.dart';

/// Process all the operation of books.
class BookProcessor {
  static const String coverFileName = 'cover.jpg';

  /// Get all book names
  static Future<List<String>> getNameList() async {
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    return await compute<Map<String, dynamic>, List<String>>(_getNameListIsolate, {
      "rootIsolateToken": rootIsolateToken,
      "path": FilePath.instance.libraryRoot,
    });
  }

  static List<String> _getNameListIsolate(Map<String, dynamic> message) {
    final RootIsolateToken rootIsolateToken = message["rootIsolateToken"];
    final String path = message["path"];

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

    final Directory folder = Directory(path);
    final List<String> entries = folder.listSync().whereType<Directory>().map((e) => e.path).toList();
    // entries.sort(compareNatural);
    return entries;
  }

  /// Get all book data
  static Future<List<BookData>> getDataList() async {
    return (await getNameList()).map((e) => BookData.fromPath(e)).toList();
  }

  /// Get the book directory
  static Directory getDirectoryByName(String name) {
    return Directory(getPathByName(name));
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

  /// Folder process
  /// Create folder
  static bool create(String name) {
    final Directory folder = Directory(getPathByName(name));
    if (!folder.existsSync()) {
      bool isSuccess = true;
      folder.createSync(recursive: true);
      isSuccess = isSuccess && folder.existsSync();
      return isSuccess;
    }
    return false;
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

  /// Delete folder
  static bool delete(String name) {
    final Directory folder = Directory(getPathByName(name));
    if (folder.existsSync()) {
      folder.deleteSync(recursive: true);
    }
    return !folder.existsSync();
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

  /// Check if the book exists
  static bool isExist(String name) {
    return Directory(getPathByName(name)).existsSync();
  }

  /// Check if the cover exists
  static bool isCoverExist(String name) {
    return File(getCoverPathByName(name)).existsSync();
  }

  static Future<bool> importFromZip(File zipFile, {ZipEncoding? zipEncoding}) async {
    Directory tempFolder = RandomUtility.getAvailableTempFolder();

    try {
      await ZipFile.extractToDirectory(
        zipFile: zipFile,
        destinationDir: tempFolder,
        zipFileCharset: zipEncoding?.value ?? ZipEncoding.utf8.value,
      );
    } catch (e) {
      tempFolder.deleteSync(recursive: true);
      return false;
    }

    final List<Directory> bookFolders = tempFolder.listSync().whereType<Directory>().toList();

    for (Directory bookFolder in bookFolders) {
      final String bookName = basename(bookFolder.path);
      BookProcessor.create(bookName);
      await ChapterProcessor.importFromFolder(bookName, bookFolder);
    }

    tempFolder.deleteSync(recursive: true);
    return true;
  }

  static Future<bool> importFromEpub(File epubFile) async {
    // final EpubBook epubBook = await EpubReader.readBook(epubFile.readAsBytesSync());
    // TODO: parse the epub book.
    // print(epubBook.Title);
    // print(epubBook.Author);
    // print(epubBook.CoverImage);
    // print(epubBook.Chapters?.map((e) => "${e.Title ?? "no title"} ${e.ContentFileName ?? ""}").toList());

    return false;
  }
}
