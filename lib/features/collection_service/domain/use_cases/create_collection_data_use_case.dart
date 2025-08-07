import '../../../../core/use_cases/use_case.dart';
import '../entities/collection_data.dart';
import '../repositories/collection_repository.dart';

class CreateCollectionDataUseCase
    extends UseCase<Future<CollectionData>, String?> {
  const CreateCollectionDataUseCase(this._repository);

  final CollectionRepository _repository;

  @override
  Future<CollectionData> call([String? parameter]) {
    return _repository.createData(parameter);
  }
}
