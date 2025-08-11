import '../../../../core/use_cases/use_case.dart';
import '../../../reader/domain/use_cases/reader_delete_location_cache_use_case.dart';
import '../repositories/book_repository.dart';

class BookDeleteUseCase extends UseCase<Future<bool>, String> {
  const BookDeleteUseCase(
    this._repository,
    this._readerDeleteLocationCacheUseCase,
  );

  final BookRepository _repository;
  final ReaderDeleteLocationCacheUseCase _readerDeleteLocationCacheUseCase;

  @override
  Future<bool> call(String parameter) async {
    await _readerDeleteLocationCacheUseCase(parameter);
    return _repository.delete(parameter);
  }
}
