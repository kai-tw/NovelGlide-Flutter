import '../../../../core/use_cases/use_case.dart';
import '../repositories/book_repository.dart';

class BookPickUseCase extends UseCase<Future<Set<String>>, Set<String>> {
  const BookPickUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<Set<String>> call(Set<String> parameter) {
    return _repository.pickBooks(parameter);
  }
}
