import 'dart:io';

import 'package:path/path.dart';

import '../exceptions/file_exceptions.dart';
import '../utils/file_path.dart';
import '../utils/file_utils.dart';
import 'bookmark_repository.dart';
import 'collection_repository.dart';

class BookRepository {
  BookRepository._();

  /// Add a book to the library.
  static void add(String filePath) {
    final destination = join(FilePath.libraryRoot, basename(filePath));
    final file = File(filePath);
    if (File(destination).existsSync()) {
      throw FileDuplicatedException();
    }
    file.copySync(destination);
  }

  /// Delete the book and associated bookmarks and collections.
  static bool delete(String filePath) {
    final file = File(filePath);
    if (file.existsSync()) {
      file.deleteSync();
    }

    // Delete associated bookmarks.
    BookmarkRepository.deleteAssociatedBook(filePath);

    // Delete associated collections.
    CollectionRepository.deleteAssociatedBook(filePath);

    return !file.existsSync();
  }

  static String getBookRelativePath(String filePath) {
    return FileUtils.getRelativePath(filePath, from: FilePath.libraryRoot);
  }
}
