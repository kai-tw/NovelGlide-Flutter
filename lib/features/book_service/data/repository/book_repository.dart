part of '../../book_service.dart';

class BookRepository {
  BookRepository();

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
    final epub.EpubBook epubBook = await EpubUtils.loadEpubBook(absolutePath);
    return BookData(
      absoluteFilePath: absolutePath,
      name: epubBook.Title ?? '',
      coverImage: EpubUtils.findCoverImage(epubBook),
    );
  }

  Stream<BookData> getBookList() async* {
    final Directory folder = await FileSystemService.document.libraryDirectory;
    final Iterable<File> fileList =
        folder.listSync().whereType<File>().where((File e) => isFileValid(e));
    for (File epubFile in fileList) {
      yield await getBookData(epubFile.path);
    }
  }

  Stream<BookData> getBookListFromPathList(List<String> pathList) async* {
    for (String path in pathList) {
      yield await getBookData(path);
    }
  }

  Future<List<ChapterData>> getChapterList(String path) =>
      EpubUtils.getChapterList(path);

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

  /// Get is the book is in the library.
  Future<bool> exists(String filePath) async {
    final Directory libraryDirectory =
        await FileSystemService.document.libraryDirectory;
    final String destination = join(libraryDirectory.path, basename(filePath));
    return File(destination).existsSync();
  }

  /// Delete the book and associated bookmarks and collections.
  bool delete(BookData bookData) {
    final String absolutePath = bookData.absoluteFilePath;
    final File file = File(absolutePath);
    if (file.existsSync()) {
      file.deleteSync();
    }

    // Delete associated bookmarks.
    BookmarkService.repository.deleteByPath(absolutePath);

    // Delete associated collections.
    CollectionService.repository.removeBookFromAll(absolutePath);

    // Delete locations cache.
    LocationCacheRepository.delete(absolutePath);

    // Send a notification.
    onChangedController.add(null);

    return !file.existsSync();
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

  /// Reset the book repository.
  Future<void> reset() async {
    final Directory directory =
        await FileSystemService.document.libraryDirectory;
    directory.deleteSync(recursive: true);
    directory.createSync(recursive: true);

    BookmarkService.repository.reset();
    CollectionService.repository.removeAllBooksFromAll();
    LocationCacheRepository.clear();

    // Send a notification.
    onChangedController.add(null);
  }
}
