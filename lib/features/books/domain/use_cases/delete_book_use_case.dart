import '../../../../core/use_cases/use_case.dart';
import '../repository/book_repository.dart';

class DeleteBookUseCase extends UseCase<Future<bool>, String> {
  const DeleteBookUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<bool> call(String parameter) {
    return _repository.delete(parameter);
  }
}
