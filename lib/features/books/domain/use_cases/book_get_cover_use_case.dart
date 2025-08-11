import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/book_cover.dart';
import '../repositories/book_repository.dart';

class BookGetCoverUseCase extends UseCase<Future<BookCover>, String> {
  const BookGetCoverUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<BookCover> call(String parameter) {
    return _repository.getCover(parameter);
  }
}
