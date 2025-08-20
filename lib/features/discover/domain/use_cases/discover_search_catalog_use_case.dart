import 'package:equatable/equatable.dart';

import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/catalog_feed.dart';
import '../repositories/discover_repository.dart';

/// This use case searches a given catalog feed with a query.
///
/// It depends on the DiscoverRepository to perform the data operation.
class DiscoverSearchCatalogUseCase
    implements UseCase<Future<CatalogFeed>, DiscoverSearchCatalogParam> {
  const DiscoverSearchCatalogUseCase(this._repository);

  final DiscoverRepository _repository;

  @override
  Future<CatalogFeed> call(DiscoverSearchCatalogParam params) {
    return _repository.searchCatalog(params.url, params.query);
  }
}

/// A class to hold the parameters for the search use case.
class DiscoverSearchCatalogParam extends Equatable {
  const DiscoverSearchCatalogParam({
    required this.url,
    required this.query,
  });

  final String url;
  final String query;

  @override
  List<Object?> get props => <Object?>[url, query];
}
