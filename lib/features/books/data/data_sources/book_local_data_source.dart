import 'dart:io';

import '../../domain/entities/book.dart';

abstract class BookLocalDataSource {
  BookLocalDataSource();

  abstract final List<String> allowedExtensions;
  abstract final List<String> allowedMimeTypes;

  Future<void> addBooks(Set<String> externalPathSet);
  Future<bool> exists(String identifier);
  Future<bool> delete(String identifier);
  Future<void> deleteAllBooks();
  Future<Book> getBook(String identifier);
  Stream<Book> getBookList();
  Stream<Book> getBookListByIdentifierSet(Set<String> identifierSet);

  // Validator
  bool isFileValid(File file);
}
