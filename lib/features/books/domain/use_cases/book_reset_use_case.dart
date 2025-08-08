import '../../../../core/use_cases/use_case.dart';
import '../../../bookmark_service/bookmark_service.dart';
import '../../../collection/domain/use_cases/delete_all_books_from_collection_use_case.dart';
import '../../../reader/data/repository/cache_repository.dart';
import '../repository/book_repository.dart';

class BookResetUseCase extends UseCase<Future<void>, void> {
  const BookResetUseCase(
    this._repository,
    this._deleteAllBooksFromCollectionUseCase,
  );

  final BookRepository _repository;
  final DeleteAllBooksFromCollectionUseCase
      _deleteAllBooksFromCollectionUseCase;

  @override
  Future<void> call([void parameter]) async {
    await _repository.reset();

    // Delete all books from every collection.
    await _deleteAllBooksFromCollectionUseCase();

    // Reset other systems.
    await BookmarkService.repository.reset();
    await LocationCacheRepository.clear();
  }
}
