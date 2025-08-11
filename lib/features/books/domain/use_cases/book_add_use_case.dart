import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/book_repository.dart';

class BookAddUseCase extends UseCase<Future<void>, Set<String>> {
  const BookAddUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<void> call(Set<String> parameter) {
    return _repository.addBooks(parameter);
  }
}
