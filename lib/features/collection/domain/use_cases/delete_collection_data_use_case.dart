import '../../../../core/use_cases/use_case.dart';
import '../entities/collection_data.dart';
import '../repositories/collection_repository.dart';

class DeleteCollectionDataUseCase
    extends UseCase<Future<void>, Set<CollectionData>> {
  const DeleteCollectionDataUseCase(this._repository);

  final CollectionRepository _repository;

  @override
  Future<void> call(Set<CollectionData> parameter) {
    return _repository.deleteData(parameter);
  }
}
