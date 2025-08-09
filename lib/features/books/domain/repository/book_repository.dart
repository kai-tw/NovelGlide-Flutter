import 'dart:async';
import 'dart:typed_data';

import '../entities/book.dart';
import '../entities/book_chapter.dart';
import '../entities/book_cover.dart';

abstract class BookRepository {
  List<String> get allowedExtensions;

  List<String> get allowedMimeTypes;

  StreamController<void> get onChangedController;

  Future<void> addBooks(Set<String> externalPathSet);

  Future<bool> exists(String identifier);

  Future<bool> delete(String identifier);

  Future<void> deleteAllBooks();

  Future<Book> getBook(String identifier);

  Stream<Book> getBooks([Set<String>? identifierSet]);

  Future<Set<String>> pickBooks(Set<String> selectedFileName);

  Future<Uint8List> readBookBytes(String identifier);

  Future<BookCover> getCover(String identifier);

  Future<List<BookChapter>> getChapterList(String identifier);

  Future<void> clearTemporaryPickedBooks();

  Future<void> reset();
}
