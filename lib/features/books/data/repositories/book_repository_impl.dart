import 'dart:async';
import 'dart:typed_data';

import 'package:novel_glide/features/books/domain/entities/book.dart';

import '../../domain/entities/book_chapter.dart';
import '../../domain/entities/book_cover.dart';
import '../../domain/repositories/book_repository.dart';
import '../data_sources/book_local_data_source.dart';
import '../data_sources/pick_book_data_source.dart';

class BookRepositoryImpl implements BookRepository {
  BookRepositoryImpl(
    this._epubDataSource,
    this._pickBookDataSource,
  );

  final BookLocalDataSource _epubDataSource;
  final PickBookDataSource _pickBookDataSource;

  @override
  List<String> get allowedExtensions => _epubDataSource.allowedExtensions;

  @override
  List<String> get allowedMimeTypes => _epubDataSource.allowedMimeTypes;

  final StreamController<void> _onChangedController =
      StreamController<void>.broadcast();

  @override
  StreamController<void> get onChangedController => _onChangedController;

  @override
  Future<void> addBooks(Set<String> externalPathSet) async {
    await _epubDataSource.addBooks(externalPathSet);

    // Send a notification
    onChangedController.add(null);
  }

  @override
  Future<bool> delete(String identifier) async {
    final bool result = await _epubDataSource.delete(identifier);

    // Send a notification.
    onChangedController.add(null);

    return result;
  }

  @override
  Future<bool> exists(String identifier) {
    return _epubDataSource.exists(identifier);
  }

  @override
  Future<Book> getBook(String identifier) {
    return _epubDataSource.getBook(identifier);
  }

  @override
  Stream<Book> getBooks([Set<String>? identifierSet]) {
    return _epubDataSource.getBooks(identifierSet);
  }

  @override
  Future<Set<String>> pickBooks(Set<String> selectedFileName) {
    return _pickBookDataSource.pickFiles(
      allowedExtensions: allowedExtensions,
      selectedFileName: selectedFileName,
    );
  }

  @override
  Future<Uint8List> readBookBytes(String identifier) async {
    return _epubDataSource.readBookBytes(identifier);
  }

  @override
  Future<BookCover> getCover(String identifier) async {
    return _epubDataSource.getCover(identifier);
  }

  @override
  Future<List<BookChapter>> getChapterList(String identifier) {
    return _epubDataSource.getChapterList(identifier);
  }

  @override
  Future<void> clearTemporaryPickedBooks() {
    return _pickBookDataSource.clearTemporaryFiles();
  }

  @override
  Future<void> reset() async {
    await _epubDataSource.deleteAllBooks();

    // Send a notification.
    onChangedController.add(null);
  }

  @override
  Future<bool> isFileValid(String path) {
    return _epubDataSource.isFileValid(path);
  }
}
