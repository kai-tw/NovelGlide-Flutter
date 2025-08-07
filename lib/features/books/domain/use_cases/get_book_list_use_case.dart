import '../../../../core/use_cases/use_case.dart';
import '../entities/book.dart';
import '../repository/book_repository.dart';

class GetBookListUseCase extends UseCase<Stream<Book>, void> {
  const GetBookListUseCase(this._repository);

  final BookRepository _repository;

  @override
  Stream<Book> call([void parameter]) {
    return _repository.getBooks();
  }
}
