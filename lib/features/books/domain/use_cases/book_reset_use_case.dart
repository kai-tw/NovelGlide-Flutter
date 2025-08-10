import '../../../../core/use_cases/use_case.dart';
import '../../../bookmark_service/bookmark_service.dart';
import '../../../collection/domain/use_cases/collection_delete_all_books_use_case.dart';
import '../../../reader/domain/use_cases/reader_clear_location_cache_use_case.dart';
import '../repository/book_repository.dart';

class BookResetUseCase extends UseCase<Future<void>, void> {
  const BookResetUseCase(
    this._repository,
    this._deleteAllBooksFromCollectionUseCase,
    this._readerClearLocationCacheUseCase,
  );

  final BookRepository _repository;
  final CollectionDeleteAllBooksUseCase _deleteAllBooksFromCollectionUseCase;
  final ReaderClearLocationCacheUseCase _readerClearLocationCacheUseCase;

  @override
  Future<void> call([void parameter]) async {
    await _repository.reset();

    // Delete all books from every collection.
    await _deleteAllBooksFromCollectionUseCase();

    // Reset other systems.
    await BookmarkService.repository.reset();
    await _readerClearLocationCacheUseCase();
  }
}
