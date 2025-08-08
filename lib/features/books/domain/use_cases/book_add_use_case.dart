import '../../../../core/use_cases/use_case.dart';
import '../repository/book_repository.dart';

class BookAddUseCase extends UseCase<Future<void>, Set<String>> {
  const BookAddUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<void> call(Set<String> parameter) {
    return _repository.addBooks(parameter);
  }
}
