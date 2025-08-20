import 'package:http/http.dart' as http;

import '../../main.dart';
import 'data/data_sources/discover_data_source.dart';
import 'data/data_sources/opds_data_source_impl.dart';
import 'data/repositories/discover_repository_impl.dart';
import 'domain/repositories/discover_repository.dart';
import 'domain/use_cases/discover_browse_catalog_use_case.dart';
import 'domain/use_cases/discover_search_catalog_use_case.dart';
import 'presentation/browser/cubits/discover_browser_cubit.dart';

void setupDiscoverDependencies() {
  // Register external dependencies
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Register data sources
  sl.registerLazySingleton<DiscoverDataSource>(
    () => OpdsDataSourceImpl(),
  );

  // Register repositories
  sl.registerLazySingleton<DiscoverRepository>(
    () => DiscoverRepositoryImpl(sl<DiscoverDataSource>()),
  );

  // Register use cases
  sl.registerFactory<DiscoverBrowseCatalogUseCase>(
    () => DiscoverBrowseCatalogUseCase(sl<DiscoverRepository>()),
  );
  sl.registerFactory<DiscoverSearchCatalogUseCase>(
    () => DiscoverSearchCatalogUseCase(sl<DiscoverRepository>()),
  );

  // Register cubits
  sl.registerFactory<DiscoverBrowserCubit>(
    () => DiscoverBrowserCubit(sl<DiscoverBrowseCatalogUseCase>()),
  );
}
