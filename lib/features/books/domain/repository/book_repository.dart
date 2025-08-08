import 'dart:async';

import '../entities/book.dart';

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
  Future<void> clearTemporaryPickedBooks();
  Future<void> reset();
}
