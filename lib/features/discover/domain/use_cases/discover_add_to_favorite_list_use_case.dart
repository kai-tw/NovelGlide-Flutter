import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/discover_favorite_catalog_data.dart';
import '../repositories/discover_favorite_repository.dart';

/// Add a favorite server to the list
class DiscoverAddToFavoriteListUseCase
    extends UseCase<Future<void>, DiscoverFavoriteCatalogData> {
  DiscoverAddToFavoriteListUseCase(this._repository);

  final DiscoverFavoriteRepository _repository;

  @override
  Future<void> call(DiscoverFavoriteCatalogData parameter) async {
    // Get the list.
    final List<String> identifierList = await _repository.getList();

    if (!identifierList.contains(parameter.identifier)) {
      // Doesn't exist in the list. Add to the list.
      identifierList.add(parameter.identifier);

      // Save the list.
      await _repository.saveList(identifierList);
    }

    if (await _repository.existsData(parameter.identifier)) {
      // Update data
      _repository.updateData(parameter);
    } else {
      // Create data
      _repository.createData(parameter);
    }
  }
}
