import '../../../../core/use_cases/use_case.dart';
import '../repositories/collection_repository.dart';

class CollectionResetUseCase extends UseCase<Future<void>, void> {
  const CollectionResetUseCase(this._repository);

  final CollectionRepository _repository;

  @override
  Future<void> call([void parameter]) {
    return _repository.reset();
  }
}
