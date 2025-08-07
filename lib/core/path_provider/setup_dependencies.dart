import '../../main.dart';
import 'data/data_sources/app_path_provider_data_source.dart';
import 'data/data_sources/impl/app_path_provider_local_data_source.dart';
import 'data/repositories/app_path_provider_impl.dart';
import 'domain/repositories/app_path_provider.dart';

void setupPathProviderDependencies() {
  // Register data source
  sl.registerLazySingleton<AppPathProviderDataSource>(
    () => AppPathProviderLocalDataSource(),
  );

  // Register repositories
  sl.registerLazySingleton<AppPathProvider>(
    () => AppPathProviderImpl(sl<AppPathProviderLocalDataSource>()),
  );
}
