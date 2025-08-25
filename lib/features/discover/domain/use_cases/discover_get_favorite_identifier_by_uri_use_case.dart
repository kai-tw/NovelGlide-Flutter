import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/discover_favorite_catalog_data.dart';
import '../repositories/discover_favorite_repository.dart';

class DiscoverGetFavoriteIdentifierByUriUseCase
    extends UseCase<Future<String?>, Uri> {
  const DiscoverGetFavoriteIdentifierByUriUseCase(this._repository);

  final DiscoverFavoriteRepository _repository;

  @override
  Future<String?> call(Uri parameter) async {
    final List<String> favorites = await _repository.getList();

    for (final String identifier in favorites) {
      final DiscoverFavoriteCatalogData? data =
          await _repository.readData(identifier);
      if (data?.uri == parameter) {
        return data?.identifier;
      }
    }

    return null;
  }
}
