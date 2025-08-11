import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/book.dart';
import '../repositories/book_repository.dart';

class BookGetListUseCase extends UseCase<Stream<Book>, void> {
  const BookGetListUseCase(this._repository);

  final BookRepository _repository;

  @override
  Stream<Book> call([void parameter]) {
    return _repository.getBooks();
  }
}
