import 'dart:io';

import 'package:path/path.dart';

import '../data_model/collection_data.dart';
import '../exceptions/file_exceptions.dart';
import '../utils/file_path.dart';
import '../utils/file_utils.dart';
import 'bookmark_repository.dart';
import 'collection_repository.dart';

class BookRepository {
  BookRepository._();

  /// Add a book to the library.
  static void add(String filePath) {
    final file = File(filePath);
    if (file.existsSync()) {
      throw FileDuplicatedException();
    }
    file.copySync(join(FilePath.libraryRoot, basename(filePath)));
  }

  /// Delete the book and associated bookmarks and collections.
  static bool delete(String filePath) {
    final file = File(filePath);
    if (file.existsSync()) {
      file.deleteSync();
    }

    // Delete associated bookmarks.
    final bookmarkList = BookmarkRepository.getList()
        .where((element) => element.bookPath == filePath);
    for (final data in bookmarkList) {
      BookmarkRepository.delete(data);
    }

    // Delete associated collections.
    final collectionList = CollectionRepository.getList()
        .where((element) => element.pathList.contains(filePath));
    for (CollectionData data in collectionList) {
      data.pathList.remove(filePath);
      CollectionRepository.save(data);
    }

    return !file.existsSync();
  }

  static String getBookRelativePath(String filePath) {
    return FileUtils.getRelativePath(filePath, from: FilePath.libraryRoot);
  }
}
