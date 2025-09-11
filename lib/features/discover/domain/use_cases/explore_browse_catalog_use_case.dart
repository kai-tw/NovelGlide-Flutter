import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/catalog_feed.dart';
import '../repositories/explore_repository.dart';

class ExploreBrowseCatalogUseCase
    implements UseCase<Future<CatalogFeed?>, Uri> {
  const ExploreBrowseCatalogUseCase(this._repository);

  final ExploreRepository _repository;

  @override
  Future<CatalogFeed?> call(Uri uri) {
    return _repository.browseCatalog(uri);
  }
}
