import '../../../../core/use_cases/use_case.dart';
import '../repositories/book_repository.dart';

class BookIsFileValidUseCase extends UseCase<bool, String> {
  const BookIsFileValidUseCase(this._repository);

  final BookRepository _repository;

  @override
  bool call(String parameter) {
    return _repository.isFileValid(parameter);
  }
}
