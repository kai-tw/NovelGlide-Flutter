import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/explore_favorite_catalog_data.dart';
import '../repositories/explore_favorite_repository.dart';

/// Get the favorite list.
class ExploreGetFavoriteListUseCase
    extends UseCase<Future<List<ExploreFavoriteCatalogData>>, void> {
  ExploreGetFavoriteListUseCase(this._repository);

  final ExploreFavoriteRepository _repository;

  @override
  Future<List<ExploreFavoriteCatalogData>> call([void parameter]) async {
    // Get the identifier list.
    final List<String> identifierList = await _repository.getList();

    // The data list.
    final List<ExploreFavoriteCatalogData> dataList =
        <ExploreFavoriteCatalogData>[];

    for (String identifier in identifierList) {
      // Read the data.
      final ExploreFavoriteCatalogData? data =
          await _repository.readData(identifier);

      if (data != null) {
        // If it's not null, add to the data list.
        dataList.add(data);
      }
    }

    return dataList;
  }
}
