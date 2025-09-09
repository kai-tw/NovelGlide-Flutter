import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/collection_data.dart';
import '../repositories/collection_repository.dart';

class CollectionCreateDataUseCase
    extends UseCase<Future<CollectionData>, String?> {
  const CollectionCreateDataUseCase(this._repository);

  final CollectionRepository _repository;

  @override
  Future<CollectionData> call([String? parameter]) {
    return _repository.createData(parameter);
  }
}
