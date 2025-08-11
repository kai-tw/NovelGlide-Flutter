import '../../../../core/use_cases/use_case.dart';
import '../entities/book.dart';
import '../repositories/book_repository.dart';

class BookGetUseCase extends UseCase<Future<Book>, String> {
  const BookGetUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<Book> call(String parameter) {
    return _repository.getBook(parameter);
  }
}
