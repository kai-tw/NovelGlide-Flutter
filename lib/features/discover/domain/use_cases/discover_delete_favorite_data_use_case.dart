import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/discover_favorite_repository.dart';

class DiscoverDeleteFavoriteDataUseCase extends UseCase<Future<void>, String> {
  DiscoverDeleteFavoriteDataUseCase(this._repository);

  final DiscoverFavoriteRepository _repository;

  @override
  Future<void> call(String parameter) async {
    await _repository.deleteData(parameter);
  }
}
