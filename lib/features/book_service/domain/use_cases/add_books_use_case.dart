import '../../../../core/use_cases/use_case.dart';
import '../repository/book_repository.dart';

class AddBooksUseCase extends UseCase<Future<void>, Set<String>> {
  const AddBooksUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<void> call(Set<String> parameter) {
    return _repository.addBooks(parameter);
  }
}
