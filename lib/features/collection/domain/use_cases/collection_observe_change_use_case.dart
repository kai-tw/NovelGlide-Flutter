import '../../../../core/use_cases/use_case.dart';
import '../repositories/collection_repository.dart';

class CollectionObserveChangeUseCase extends UseCase<Stream<void>, void> {
  const CollectionObserveChangeUseCase(this._repository);

  final CollectionRepository _repository;

  @override
  Stream<void> call([void parameter]) {
    return _repository.onChangedStream;
  }
}
