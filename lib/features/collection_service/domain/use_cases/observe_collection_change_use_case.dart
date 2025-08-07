import '../../../../core/use_cases/use_case.dart';
import '../repositories/collection_repository.dart';

class ObserveCollectionChangeUseCase extends UseCase<Stream<void>, void> {
  const ObserveCollectionChangeUseCase(this._repository);

  final CollectionRepository _repository;

  @override
  Stream<void> call([void parameter]) {
    return _repository.onChangedController.stream;
  }
}
