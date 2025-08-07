import '../../../../core/use_cases/use_case.dart';
import '../entities/book.dart';
import '../repository/book_repository.dart';

class GetBookListByIdentifierSetUseCase
    extends UseCase<Stream<Book>, Set<String>> {
  const GetBookListByIdentifierSetUseCase(this._repository);

  final BookRepository _repository;

  @override
  Stream<Book> call(Set<String> parameters) {
    return _repository.getBookListByIdentifierSet(parameters);
  }
}
