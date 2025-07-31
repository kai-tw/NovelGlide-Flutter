part of '../file_system_service.dart';

class EpubRepository extends FileSystemRepository {
  const EpubRepository();

  /// Loads an EpubBook asynchronously, potentially a heavy operation.
  Future<epub.EpubBook> loadEpubBook(String filePath) async {
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    return await compute<Map<String, dynamic>, epub.EpubBook>(
        _loadEpubBookIsolate, <String, dynamic>{
      'rootIsolateToken': rootIsolateToken,
      'path': filePath,
    });
  }

  /// Isolate function to load an EpubBook.
  Future<epub.EpubBook> _loadEpubBookIsolate(
      Map<String, dynamic> message) async {
    final RootIsolateToken rootIsolateToken = message['rootIsolateToken'];
    final String path = message['path'];
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    return await epub.EpubReader.readBook(File(path).readAsBytesSync());
  }

  /// Retrieve the list of chapters from a epub book_service.
  Future<List<ChapterData>> getChapterList(String filePath) async {
    final epub.EpubBook epubBook = await loadEpubBook(filePath);
    return epubBook.Chapters?.map(
            (epub.EpubChapter e) => ChapterData.fromEpubChapter(e)).toList() ??
        <ChapterData>[];
  }

  /// Find the possible cover image of the book_service.
  epub.Image? findCoverImage(epub.EpubBook epubBook) {
    // The cover image found by epub package.
    if (epubBook.CoverImage != null) {
      return epubBook.CoverImage!;
    }

    // Search the cover image in the manifest.
    if (epubBook.Schema?.Package?.Manifest != null) {
      final epub.EpubManifest manifest = epubBook.Schema!.Package!.Manifest!;
      final epub.EpubManifestItem? coverItem = manifest.Items!.firstWhereOrNull(
          (epub.EpubManifestItem item) =>
              item.Href != null &&
              (item.Id?.toLowerCase() == 'cover' ||
                  item.Id?.toLowerCase() == 'cover-image' ||
                  item.Properties?.toLowerCase() == 'cover' ||
                  item.Properties?.toLowerCase() == 'cover-image') &&
              (item.MediaType?.toLowerCase() == 'image/jpeg' ||
                  item.MediaType?.toLowerCase() == 'image/png' ||
                  item.MediaType?.toLowerCase() == 'image/gif' ||
                  item.MediaType?.toLowerCase() == 'image/bmp'));
      if (coverItem != null) {
        return _readImage(epubBook, coverItem.Href!);
      }
    }

    // Not found.
    return null;
  }

  /// Read an image from the book_service.
  epub.Image? _readImage(epub.EpubBook epubBook, String href) {
    if (epubBook.Content?.Images?.containsKey(href) == true) {
      final epub.EpubByteContentFile ref = epubBook.Content!.Images![href]!;
      final List<int>? content = ref.Content;
      return content == null ? null : decodeImage(content);
    }
    return null;
  }
}
