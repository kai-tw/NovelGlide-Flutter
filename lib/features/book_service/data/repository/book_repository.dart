part of '../../book_service.dart';

class BookRepository {
  BookRepository();

  final List<String> allowedExtensions = <String>['epub'];
  final List<String> allowedMimeTypes = <String>['application/epub+zip'];

  /// Check if the mime of a file is valid.
  bool isMimeValid(File file) {
    return allowedMimeTypes.contains(MimeResolver.lookupAll(file));
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
        folder.listSync().whereType<File>().where((File e) => isMimeValid(e));
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

  /// Add a book to the library.
  Future<void> addBook(String filePath) async {
    final Directory libraryDirectory =
        await FileSystemService.document.libraryDirectory;
    final String destination = join(libraryDirectory.path, basename(filePath));
    File(filePath).copySync(destination);
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
    CollectionService.repository.deleteFromAll(absolutePath);

    // Delete locations cache.
    LocationCacheRepository.delete(absolutePath);

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
    CollectionService.repository.reset();
    LocationCacheRepository.clear();
  }
}
