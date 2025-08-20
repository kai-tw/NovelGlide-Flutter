import 'package:http/http.dart' as http;

import '../../main.dart';
import 'data/data_sources/discover_data_source.dart';
import 'data/data_sources/opds_data_source_impl.dart';
import 'data/repositories/discover_repository_impl.dart';
import 'domain/repositories/discover_repository.dart';
import 'presentation/catalog_viewer/cubits/discover_catalog_viewer_cubit.dart';

void setupDiscoverDependencies() {
  // Register external dependencies
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Register data sources
  sl.registerLazySingleton<DiscoverDataSource>(
    () => OpdsDataSourceImpl(),
  );

  // Register repositories
  sl.registerLazySingleton<DiscoverRepository>(
    () => DiscoverRepositoryImpl(sl()),
  );

  // Register cubits
  sl.registerFactory<DiscoverCatalogViewerCubit>(
    () => DiscoverCatalogViewerCubit(sl()),
  );
}
