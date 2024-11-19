import 'dart:io';

import 'package:path/path.dart';

import '../exceptions/file_exceptions.dart';
import '../utils/file_path.dart';
import '../utils/file_utils.dart';
import '../utils/json_utils.dart';
import 'bookmark_repository.dart';
import 'collection_repository.dart';
import 'repository_interface.dart';

class BookRepository {
  BookRepository._();

  static String jsonFileName = 'book.json';

  static String get jsonPath => RepositoryInterface.getJsonPath(jsonFileName);

  static File get jsonFile => RepositoryInterface.getJsonFile(jsonPath);

  static Map<String, dynamic> get jsonData => JsonUtils.fromFile(jsonFile);

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

  static String getBookAbsolutePath(String filePath) {
    return absolute(FilePath.libraryRoot, filePath);
  }

  /// Reset the book repository.
  static void reset() {
    final directory = Directory(FilePath.libraryRoot);
    directory.deleteSync(recursive: true);
    directory.createSync(recursive: true);
  }
}
