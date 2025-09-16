import '../../core/http_client/domain/repositories/http_client_repository.dart';
import '../../main.dart';
import 'data/data_sources/impl/manual_local_data_source_impl.dart';
import 'data/data_sources/impl/manual_remote_data_source_impl.dart';
import 'data/data_sources/manual_local_data_source.dart';
import 'data/data_sources/manual_remote_data_source.dart';
import 'data/repositories/manual_repository_impl.dart';
import 'domain/repositories/manual_repository.dart';
import 'domain/use_cases/manual_load_use_case.dart';
import 'presentation/cubit/shared_manual_cubit.dart';

void setupManualDependencies() {
  // Register data sources
  sl.registerLazySingleton<ManualLocalDataSource>(
    () => ManualLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ManualRemoteDataSource>(
    () => ManualRemoteDataSourceImpl(
      sl<HttpClientRepository>(),
    ),
  );

  // Register repository
  sl.registerLazySingleton<ManualRepository>(
    () => ManualRepositoryImpl(
      sl<ManualLocalDataSource>(),
      sl<ManualRemoteDataSource>(),
    ),
  );

  // Register use cases
  sl.registerFactory<ManualLoadUseCase>(
    () => ManualLoadUseCase(
      sl<ManualRepository>(),
    ),
  );

  // Register cubits
  sl.registerFactory<SharedManualCubit>(
    () => SharedManualCubit(
      sl<ManualLoadUseCase>(),
    ),
  );
}
