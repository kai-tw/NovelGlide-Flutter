import 'dart:io';

import 'package:collection/collection.dart';
import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:path/path.dart';

import '../../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../../core/services/file_system_service/file_system_service.dart';
import '../../../../../core/services/mime_resolver.dart';
import '../../../domain/entities/book.dart';
import '../../../domain/entities/book_chapter.dart';
import '../../../domain/entities/book_cover.dart';
import '../book_local_data_source.dart';

class EpubDataSource extends BookLocalDataSource {
  EpubDataSource(this._fileSystemRepository);

  final FileSystemRepository _fileSystemRepository;

  @override
  final List<String> allowedExtensions = <String>['epub'];
  @override
  final List<String> allowedMimeTypes = <String>['application/epub+zip'];

  @override
  Future<void> addBooks(Set<String> externalPathSet) async {
    final Directory libraryDirectory =
        await FileSystemService.document.libraryDirectory;

    for (String path in externalPathSet) {
      final String destination = join(libraryDirectory.path, basename(path));
      _fileSystemRepository.copyFile(path, destination);
    }
  }

  @override
  Future<bool> delete(String identifier) async {
    final File file = File(identifier);
    if (file.existsSync()) {
      file.deleteSync();
    }

    return !file.existsSync();
  }

  @override
  Future<void> deleteAllBooks() async {
    final Directory directory =
        await FileSystemService.document.libraryDirectory;
    directory.deleteSync(recursive: true);
    directory.createSync(recursive: true);
  }

  @override
  Future<bool> exists(String identifier) async {
    final Directory libraryDirectory =
        await FileSystemService.document.libraryDirectory;
    final String destination =
        join(libraryDirectory.path, basename(identifier));
    return File(destination).existsSync();
  }

  @override
  Future<Book> getBook(String identifier) async {
    final Directory directory =
        await FileSystemService.document.libraryDirectory;
    final String absolutePath = absolute(directory.path, identifier);
    final File epubFile = File(absolutePath);
    final epub.EpubBook epubBook = await _loadEpubBook(absolutePath);
    final epub.Image? coverImage = _findCoverImage(epubBook);
    return Book(
      identifier: basename(absolutePath),
      title: epubBook.Title ?? '',
      cover: BookCover(
        identifier: basename(absolutePath),
        width: coverImage?.width.toDouble(),
        height: coverImage?.height.toDouble(),
        bytes: coverImage?.getBytes(),
      ),
      chapterList:
          epubBook.Chapters?.map((epub.EpubChapter e) => _createBookChapter(e))
                  .toList() ??
              <BookChapter>[],
      modifiedDate: epubFile.statSync().modified,
    );
  }

  @override
  Stream<Book> getBooks([Set<String>? identifierSet]) async* {
    final Set<String> idSet = identifierSet ??
        (await FileSystemService.document.libraryDirectory)
            .listSync()
            .whereType<File>()
            .where((File e) => isFileValid(e))
            .map((File e) => basename(e.path))
            .toSet();
    for (String id in idSet) {
      yield await getBook(id);
    }
  }

  @override
  Future<Uint8List> readBookBytes(String identifier) async {
    final Directory directory =
        await FileSystemService.document.libraryDirectory;
    final String absolutePath = absolute(directory.path, identifier);
    return _fileSystemRepository.readFileAsBytes(absolutePath);
  }

  @override
  bool isFileValid(File file) {
    return allowedExtensions.contains(extension(file.path).substring(1)) &&
        allowedMimeTypes.contains(MimeResolver.lookupAll(file));
  }

  /// Loads an EpubBook asynchronously, potentially a heavy operation.
  Future<epub.EpubBook> _loadEpubBook(String filePath) async {
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

  /// Find the possible cover image of the book.
  Image? _findCoverImage(epub.EpubBook epubBook) {
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
  Image? _readImage(epub.EpubBook epubBook, String href) {
    if (epubBook.Content?.Images?.containsKey(href) == true) {
      final epub.EpubByteContentFile ref = epubBook.Content!.Images![href]!;
      final List<int>? content = ref.Content;
      return content == null ? null : decodeImage(content);
    }
    return null;
  }

  /// Recursively create the nested chapter list.
  BookChapter _createBookChapter(epub.EpubChapter epubChapter) {
    return BookChapter(
      title: epubChapter.Title ?? '',
      identifier: epubChapter.ContentFileName ?? '',
      subChapterList: (epubChapter.SubChapters ?? <epub.EpubChapter>[])
          .map((epub.EpubChapter e) => _createBookChapter(e))
          .toList(),
    );
  }
}
