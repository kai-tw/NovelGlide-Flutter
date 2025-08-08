import '../../../../core/use_cases/use_case.dart';
import '../repository/book_repository.dart';

class BookObserveChangeUseCase extends UseCase<Stream<void>, void> {
  const BookObserveChangeUseCase(this._repository);

  final BookRepository _repository;

  @override
  Stream<void> call([void parameter]) {
    return _repository.onChangedController.stream;
  }
}
