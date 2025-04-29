import 'dart:io';

import 'package:epubx/epubx.dart';
import 'package:path/path.dart';

import '../../../../utils/epub_utils.dart';
import '../../../../utils/file_path.dart';
import '../../../../utils/file_utils.dart';
import '../../../bookmark/data/bookmark_repository.dart';
import '../../../collection/data/collection_repository.dart';
import '../../../reader/data/repository/cache_repository.dart';
import '../model/book_data.dart';

class BookRepository {
  BookRepository._();

  /// Add a book to the library.
  static void add(String filePath) {
    final String destination = join(FilePath.libraryRoot, basename(filePath));
    File(filePath).copySync(destination);
  }

  /// Get is the book is in the library.
  static bool exists(String filePath) {
    final String destination = join(FilePath.libraryRoot, basename(filePath));
    return File(destination).existsSync();
  }

  /// Get the book data from the file path.
  static Future<BookData> get(String filePath) async {
    final String absolutePath = getAbsolutePath(filePath);
    final EpubBook epubBook = await EpubUtils.loadEpubBook(absolutePath);
    return BookData(
      absoluteFilePath: absolutePath,
      name: epubBook.Title ?? '',
      coverImage: EpubUtils.findCoverImage(epubBook),
    );
  }

  /// Delete the book and associated bookmarks and collections.
  static bool delete(String filePath) {
    final String absolutePath = getAbsolutePath(filePath);
    final File file = File(absolutePath);
    if (file.existsSync()) {
      file.deleteSync();
    }

    // Delete associated bookmarks.
    BookmarkRepository.deleteByPath(absolutePath);

    // Delete associated collections.
    CollectionRepository.deleteByPath(absolutePath);

    // Delete locations cache.
    LocationCacheRepository.delete(absolutePath);

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
    final Directory directory = Directory(FilePath.libraryRoot);
    directory.deleteSync(recursive: true);
    directory.createSync(recursive: true);

    BookmarkRepository.reset();
    CollectionRepository.reset();
    LocationCacheRepository.clear();
  }
}
