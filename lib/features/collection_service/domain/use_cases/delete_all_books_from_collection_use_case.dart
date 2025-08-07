import '../../../../core/use_cases/use_case.dart';
import '../entities/collection_data.dart';
import '../repositories/collection_repository.dart';

class DeleteAllBooksFromCollectionUseCase extends UseCase<Future<void>, void> {
  const DeleteAllBooksFromCollectionUseCase(this._repository);

  final CollectionRepository _repository;

  @override
  Future<void> call([void parameter]) async {
    // Get the data list
    final List<CollectionData> list = await _repository.getList();

    // Remove all the books from all collections
    for (CollectionData data in list) {
      data.pathList.clear();
    }

    await _repository.updateData(list.toSet());
  }
}
