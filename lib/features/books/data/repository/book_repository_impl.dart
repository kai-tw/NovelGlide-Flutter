import 'package:novel_glide/features/books/domain/entities/book.dart';

import '../../../bookmark_service/bookmark_service.dart';
import '../../../collection_service/domain/use_cases/delete_all_books_from_collection_use_case.dart';
import '../../../reader/data/repository/cache_repository.dart';
import '../../domain/repository/book_repository.dart';
import '../data_sources/book_local_data_source.dart';
import '../data_sources/pick_book_data_source.dart';

class BookRepositoryImpl extends BookRepository {
  BookRepositoryImpl(
    this._epubDataSource,
    this._pickBookDataSource,
    this._deleteAllBooksFromCollectionUseCase,
  );

  final BookLocalDataSource _epubDataSource;
  final PickBookDataSource _pickBookDataSource;
  final DeleteAllBooksFromCollectionUseCase
      _deleteAllBooksFromCollectionUseCase;

  @override
  List<String> get allowedExtensions => _epubDataSource.allowedExtensions;
  @override
  List<String> get allowedMimeTypes => _epubDataSource.allowedMimeTypes;

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
  Future<void> deleteAllBooks() async {
    await _epubDataSource.deleteAllBooks();

    // Send a notification.
    onChangedController.add(null);
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
  Future<void> clearTemporaryPickedBooks() {
    return _pickBookDataSource.clearTemporaryFiles();
  }

  @override
  Future<void> reset() async {
    await deleteAllBooks();

    BookmarkService.repository.reset();
    _deleteAllBooksFromCollectionUseCase();
    LocationCacheRepository.clear();

    // Send a notification.
    onChangedController.add(null);
  }
}
