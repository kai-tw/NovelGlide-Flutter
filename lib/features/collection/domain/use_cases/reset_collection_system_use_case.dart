import '../../../../core/use_cases/use_case.dart';
import '../repositories/collection_repository.dart';

class ResetCollectionSystemUseCase extends UseCase<Future<void>, void> {
  const ResetCollectionSystemUseCase(this._repository);

  final CollectionRepository _repository;

  @override
  Future<void> call([void parameter]) {
    return _repository.reset();
  }
}
