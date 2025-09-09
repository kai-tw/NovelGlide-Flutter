import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/book_repository.dart';

class BookIsFileValidUseCase extends UseCase<Future<bool>, String> {
  const BookIsFileValidUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<bool> call(String parameter) {
    return _repository.isFileValid(parameter);
  }
}
