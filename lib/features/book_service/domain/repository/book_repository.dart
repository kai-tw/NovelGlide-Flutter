import 'dart:async';

import '../entities/book.dart';

abstract class BookRepository {
  List<String> get allowedExtensions;
  List<String> get allowedMimeTypes;

  final StreamController<void> onChangedController =
      StreamController<void>.broadcast();

  Future<void> addBooks(Set<String> externalPathSet);
  Future<bool> exists(String identifier);
  Future<bool> delete(String identifier);
  Future<void> deleteAllBooks();
  Future<Book> getBook(String identifier);
  Stream<Book> getBookList();
  Stream<Book> getBookListByIdentifierSet(Set<String> identifierSet);
  Future<Set<String>> pickBooks(Set<String> selectedFileName);
  Future<void> clearTemporaryPickedBooks();
  Future<void> reset();
}
