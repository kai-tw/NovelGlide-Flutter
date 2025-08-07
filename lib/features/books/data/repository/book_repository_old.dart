part of '../../book_service.dart';

class BookRepositoryOld {
  BookRepositoryOld();

  final List<String> allowedExtensions = <String>['epub'];
  final List<String> allowedMimeTypes = <String>['application/epub+zip'];
  final StreamController<void> onChangedController =
      StreamController<void>.broadcast();

  /// Check if a file is a valid book.
  bool isFileValid(File file) {
    return allowedExtensions.contains(extension(file.path).substring(1)) &&
        allowedMimeTypes.contains(MimeResolver.lookupAll(file));
  }

  /// Get the book data from the file path.
  Future<BookData> getBookData(String filePath) async {
    final Directory directory =
        await FileSystemService.document.libraryDirectory;
    final String absolutePath = absolute(directory.path, filePath);
    final epub.EpubBook epubBook =
        await FileSystemService.epub.loadEpubBook(absolutePath);
    return BookData(
      absoluteFilePath: absolutePath,
      name: epubBook.Title ?? '',
    );
  }

  /// Add some books to the library.
  Future<void> addBooks(Set<String> externalPathSet) async {
    final Directory libraryDirectory =
        await FileSystemService.document.libraryDirectory;

    for (String path in externalPathSet) {
      final String destination = join(libraryDirectory.path, basename(path));
      File(path).copySync(destination);
    }

    // Send a notification.
    onChangedController.add(null);
  }

  /// Get the relative path of the book.
  Future<String> getRelativePath(String filePath) async {
    final Directory directory =
        await FileSystemService.document.libraryDirectory;
    return isRelative(filePath)
        ? filePath
        : relative(
            filePath,
            from: directory.path,
          );
  }

  /// Get is the book is in the library.
  Future<bool> exists(String filePath) async {
    final Directory libraryDirectory =
        await FileSystemService.document.libraryDirectory;
    final String destination = join(libraryDirectory.path, basename(filePath));
    return File(destination).existsSync();
  }

  Future<void> deleteAllBooks() async {
    final Directory directory =
        await FileSystemService.document.libraryDirectory;
    directory.deleteSync(recursive: true);
    directory.createSync(recursive: true);
  }

  /// Reset the book repository.
  Future<void> reset() async {
    await deleteAllBooks();

    BookmarkService.repository.reset();
    CollectionService.repository.removeAllBooksFromAll();
    LocationCacheRepository.clear();

    // Send a notification.
    onChangedController.add(null);
  }
}
