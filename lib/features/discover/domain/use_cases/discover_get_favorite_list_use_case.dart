import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/discover_favorite_catalog_data.dart';
import '../repositories/discover_favorite_repository.dart';

/// Get the favorite list.
class DiscoverGetFavoriteListUseCase
    extends UseCase<Future<List<DiscoverFavoriteCatalogData>>, void> {
  DiscoverGetFavoriteListUseCase(this._repository);

  final DiscoverFavoriteRepository _repository;

  @override
  Future<List<DiscoverFavoriteCatalogData>> call([void parameter]) async {
    // Get the identifier list.
    final List<String> identifierList = await _repository.getList();

    // The data list.
    final List<DiscoverFavoriteCatalogData> dataList =
        <DiscoverFavoriteCatalogData>[];

    for (String identifier in identifierList) {
      // Read the data.
      final DiscoverFavoriteCatalogData? data =
          await _repository.readData(identifier);

      if (data != null) {
        // If it's not null, add to the data list.
        dataList.add(data);
      }
    }

    return dataList;
  }
}
