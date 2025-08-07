import '../../../../core/use_cases/use_case.dart';
import '../repository/book_repository.dart';

class ObserveBookChangeUseCase extends UseCase<Stream<void>, void> {
  const ObserveBookChangeUseCase(this._repository);

  final BookRepository _repository;

  @override
  Stream<void> call([void parameter]) {
    return _repository.onChangedController.stream;
  }
}
