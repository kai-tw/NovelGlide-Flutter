import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path/path.dart';

import '../data/book_data.dart';
import '../data/file_path.dart';
import 'bookmark_processor.dart';
import 'chapter_processor.dart';
import 'random_utility.dart';

/// Process all the operation of books.
class BookProcessor {
  static const String coverFileName = 'cover.jpg';

  /// Get all book names
  static List<String> getNameList() {
    final Directory folder = Directory(FilePath().libraryRoot);
    folder.createSync(recursive: true);

    final List<String> entries = folder.listSync().whereType<Directory>().map((e) => e.path).toList();
    entries.sort(compareNatural);

    return entries;
  }

  /// Get all book data
  static List<BookData> getDataList() {
    return getNameList().map((e) => BookData.fromPath(e)).toList();
  }

  /// Get the book path by name
  static String getPathByName(String name) {
    return join(FilePath().libraryRoot, name);
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
  static bool createFolder(String name) {
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
  static bool modifyFolder(String oldName, String newName) {
    final Directory oldFolder = Directory(getPathByName(oldName));
    final Directory newFolder = Directory(getPathByName(newName));

    if (newName != oldName) {
      oldFolder.renameSync(newFolder.path);
      return newFolder.existsSync();
    }
    return false;
  }

  /// Delete folder
  static bool deleteFolder(String name) {
    final Directory folder = Directory(getPathByName(name));
    if (folder.existsSync()) {
      folder.deleteSync(recursive: true);
    }
    return !folder.existsSync();
  }

  /// Cover process
  /// Create cover
  static bool createCover(String name, File coverFile) {
    File coverImage = coverFile.copySync(getCoverPathByName(name));
    return coverImage.existsSync();
  }

  /// Modify cover
  static bool modifyCover(String name, File coverFile) {
    if (coverFile.existsSync()) {
      return createCover(name, coverFile);
    }
    return false;
  }

  /// Delete cover
  static bool deleteCover(String name) {
    final File coverFile = File(getCoverPathByName(name));
    if (coverFile.existsSync()) {
      coverFile.deleteSync();
    }
    return !coverFile.existsSync();
  }

  static bool isCoverExist(String name) {
    return File(getCoverPathByName(name)).existsSync();
  }

  /// Import books from an archive file.
  static Future<bool> importFromArchive(String bookName, File archiveFile) async {
    Directory tempFolder = RandomUtility.getAvailableTempFolder();

    try {
      await ZipFile.extractToDirectory(zipFile: archiveFile, destinationDir: tempFolder);
    } catch (e) {
      tempFolder.deleteSync(recursive: true);
      rethrow;
    }

    final List<String> copyList = [
      BookmarkProcessor.bookmarkFileName,
      BookmarkProcessor.bookmarkLockFileName,
    ];

    await Future.forEach(tempFolder.listSync().whereType<File>(), (file) async {
      final String fileName = basename(file.path);
      final int? chapterNumber = int.tryParse(basenameWithoutExtension(fileName));

      if (chapterNumber != null) {
        await ChapterProcessor.create(bookName, chapterNumber, file);
      }

      if (!isCoverExist(bookName) && fileName == coverFileName) {
        BookProcessor.createCover(bookName, file);
      }

      if (copyList.contains(fileName)) {
        file.copySync(join(getPathByName(bookName), fileName));
      }
    });

    tempFolder.deleteSync(recursive: true);
    return true;
  }
}
