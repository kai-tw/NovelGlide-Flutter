import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/collection_data.dart';
import '../repositories/collection_repository.dart';

class CollectionUpdateDataUseCase
    extends UseCase<Future<void>, Set<CollectionData>> {
  const CollectionUpdateDataUseCase(this._repository);

  final CollectionRepository _repository;

  @override
  Future<void> call(Set<CollectionData> parameter) {
    return _repository.updateData(parameter);
  }
}
