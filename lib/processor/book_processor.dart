import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart';

import '../data/book_data.dart';
import '../data/file_path.dart';

/// Process all the operation of books.
class BookProcessor {
  static const String coverFileName = 'cover.jpg';

  /// Get all book names
  static List<String> getNameList() {
    final Directory folder = Directory(FilePath.instance.libraryRoot);
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
    return coverFile.existsSync() && coverFile.copySync(getCoverPathByName(name)).existsSync();
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

  static bool isCoverExist(String name) {
    return File(getCoverPathByName(name)).existsSync();
  }
}
