import '../../../../core/use_cases/use_case.dart';
import '../entities/collection_data.dart';
import '../repositories/collection_repository.dart';

class GetCollectionListUseCase
    extends UseCase<Future<List<CollectionData>>, void> {
  const GetCollectionListUseCase(this._repository);

  final CollectionRepository _repository;

  @override
  Future<List<CollectionData>> call([void parameter]) {
    return _repository.getList();
  }
}
