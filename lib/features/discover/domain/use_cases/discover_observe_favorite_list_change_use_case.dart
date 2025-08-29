import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/discover_favorite_repository.dart';

class DiscoverObserveFavoriteListChangeUseCase
    extends UseCase<Stream<void>, void> {
  DiscoverObserveFavoriteListChangeUseCase(this._repository);

  final DiscoverFavoriteRepository _repository;

  @override
  Stream<void> call([void parameter]) {
    return _repository.onListChangeStream;
  }
}
