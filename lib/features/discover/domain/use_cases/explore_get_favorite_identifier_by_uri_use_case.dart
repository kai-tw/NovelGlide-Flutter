import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/explore_favorite_catalog_data.dart';
import '../repositories/explore_favorite_repository.dart';

class ExploreGetFavoriteIdentifierByUriUseCase
    extends UseCase<Future<String?>, Uri> {
  const ExploreGetFavoriteIdentifierByUriUseCase(this._repository);

  final ExploreFavoriteRepository _repository;

  @override
  Future<String?> call(Uri parameter) async {
    final List<String> favorites = await _repository.getList();

    for (final String identifier in favorites) {
      final ExploreFavoriteCatalogData? data =
          await _repository.readData(identifier);
      if (data?.uri == parameter) {
        return data?.identifier;
      }
    }

    return null;
  }
}
