import '../../../../core/use_cases/use_case.dart';
import '../repository/book_repository.dart';

class PickBooksUseCase extends UseCase<Future<Set<String>>, Set<String>> {
  const PickBooksUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<Set<String>> call(Set<String> parameter) {
    return _repository.pickBooks(parameter);
  }
}
