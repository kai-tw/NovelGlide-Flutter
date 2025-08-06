import '../../../../core/use_cases/use_case.dart';
import '../entities/book.dart';
import '../repository/book_repository.dart';

class GetBookUseCase extends UseCase<Future<Book>, String> {
  const GetBookUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<Book> call(String parameter) {
    return _repository.getBook(parameter);
  }
}
