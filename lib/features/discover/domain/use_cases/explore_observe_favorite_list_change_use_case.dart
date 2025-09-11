import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/explore_favorite_repository.dart';

class ExploreObserveFavoriteListChangeUseCase
    extends UseCase<Stream<void>, void> {
  ExploreObserveFavoriteListChangeUseCase(this._repository);

  final ExploreFavoriteRepository _repository;

  @override
  Stream<void> call([void parameter]) {
    return _repository.onListChangeStream;
  }
}
