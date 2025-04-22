import 'dart:io';

import 'package:path/path.dart';

import '../data_model/book_data.dart';
import '../exceptions/exceptions.dart';
import '../utils/epub_utils.dart';
import '../utils/file_path.dart';
import '../utils/file_utils.dart';
import '../utils/json_utils.dart';
import 'bookmark_repository.dart';
import 'cache_repository.dart';
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

  /// Get is the book is in the library.
  static bool exists(String filePath) {
    final destination = join(FilePath.libraryRoot, basename(filePath));
    return File(destination).existsSync();
  }

  /// Get the book data from the file path.
  static Future<BookData> get(String filePath) async {
    final absolutePath = getAbsolutePath(filePath);
    final epubBook = await EpubUtils.loadEpubBook(absolutePath);
    return BookData(
      absoluteFilePath: absolutePath,
      name: epubBook.Title ?? '',
      coverImage: EpubUtils.findCoverImage(epubBook),
    );
  }

  /// Delete the book and associated bookmarks and collections.
  static bool delete(String filePath) {
    final absolutePath = getAbsolutePath(filePath);
    final file = File(absolutePath);
    if (file.existsSync()) {
      file.deleteSync();
    }

    // Delete associated bookmarks.
    BookmarkRepository.deleteAssociatedBook(absolutePath);

    // Delete associated collections.
    CollectionRepository.deleteAssociatedBook(absolutePath);

    // Delete locations cache.
    CacheRepository.deleteLocation(absolutePath);

    return !file.existsSync();
  }

  /// Get the relative path of the book.
  static String getRelativePath(String filePath) {
    return FileUtils.getRelativePath(filePath, from: FilePath.libraryRoot);
  }

  /// Get the absolute path of the book.
  static String getAbsolutePath(String filePath) {
    return absolute(FilePath.libraryRoot, filePath);
  }

  /// Reset the book repository.
  static void reset() {
    final directory = Directory(FilePath.libraryRoot);
    directory.deleteSync(recursive: true);
    directory.createSync(recursive: true);

    BookmarkRepository.reset();
    CollectionRepository.reset();
    CacheRepository.clearLocation();
  }
}
