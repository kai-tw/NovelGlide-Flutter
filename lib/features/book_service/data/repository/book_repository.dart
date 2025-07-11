part of '../../book_service.dart';

class BookRepository {
  BookRepository();

  /// Get the book data from the file path.
  Future<BookData> getBookData(String filePath) async {
    final String absolutePath = getAbsolutePath(filePath);
    final EpubBook epubBook = await EpubUtils.loadEpubBook(absolutePath);
    return BookData(
      absoluteFilePath: absolutePath,
      name: epubBook.Title ?? '',
      coverImage: EpubUtils.findCoverImage(epubBook),
    );
  }

  /// Add a book to the library.
  void add(String filePath) {
    final String destination = join(FilePath.libraryRoot, basename(filePath));
    File(filePath).copySync(destination);
  }

  /// Get is the book is in the library.
  bool exists(String filePath) {
    final String destination = join(FilePath.libraryRoot, basename(filePath));
    return File(destination).existsSync();
  }

  /// Delete the book and associated bookmarks and collections.
  bool delete(String filePath) {
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
  String getRelativePath(String filePath) {
    return FileUtils.getRelativePath(filePath, from: FilePath.libraryRoot);
  }

  /// Get the absolute path of the book.
  String getAbsolutePath(String filePath) {
    return absolute(FilePath.libraryRoot, filePath);
  }

  /// Reset the book repository.
  void reset() {
    final Directory directory = Directory(FilePath.libraryRoot);
    directory.deleteSync(recursive: true);
    directory.createSync(recursive: true);

    BookmarkRepository.reset();
    CollectionRepository.reset();
    LocationCacheRepository.clear();
  }
}
