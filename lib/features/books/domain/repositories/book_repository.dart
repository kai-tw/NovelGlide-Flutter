import 'dart:async';
import 'dart:typed_data';

import '../entities/book.dart';
import '../entities/book_chapter.dart';
import '../entities/book_cover.dart';
import '../entities/book_pick_file_data.dart';

abstract class BookRepository {
  List<String> get allowedExtensions;

  StreamController<void> get onChangedController;

  Future<void> addBooks(Set<String> externalPathSet);

  Future<bool> exists(String identifier);

  Future<bool> delete(String identifier);

  Future<Book> getBook(String identifier);

  Stream<Book> getBooks([Set<String>? identifierSet]);

  Future<Set<BookPickFileData>> pickBooks();

  Future<Uint8List> readBookBytes(String identifier);

  Future<BookCover> getCover(String identifier);

  Future<List<BookChapter>> getChapterList(String identifier);

  Future<void> clearTemporaryPickedBooks();

  Future<void> reset();

  Future<bool> isFileValid(String path);
}
