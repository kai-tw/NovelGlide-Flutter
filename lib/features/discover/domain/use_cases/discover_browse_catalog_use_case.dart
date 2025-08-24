import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/catalog_feed.dart';
import '../repositories/discover_repository.dart';

class DiscoverBrowseCatalogUseCase
    implements UseCase<Future<CatalogFeed>, Uri> {
  const DiscoverBrowseCatalogUseCase(this._repository);

  final DiscoverRepository _repository;

  @override
  Future<CatalogFeed> call(Uri uri) {
    return _repository.browseCatalog(uri);
  }
}
