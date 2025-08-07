import '../../../../core/use_cases/use_case.dart';
import '../repository/book_repository.dart';

class ResetBookSystemUseCase extends UseCase<Future<void>, void> {
  const ResetBookSystemUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<void> call([void parameter]) {
    return _repository.reset();
  }
}
