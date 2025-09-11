import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/explore_favorite_repository.dart';

class ExploreRemoveFromFavoriteListUseCase
    extends UseCase<Future<void>, String> {
  ExploreRemoveFromFavoriteListUseCase(this._repository);

  final ExploreFavoriteRepository _repository;

  @override
  Future<void> call(String parameter) async {
    await _repository.deleteData(parameter);
  }
}
