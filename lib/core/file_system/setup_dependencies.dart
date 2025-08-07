import '../../main.dart';
import '../path_provider/domain/repositories/app_path_provider.dart';
import 'data/repositories/file_system_repository_impl.dart';
import 'data/repositories/json_repository_impl.dart';
import 'domain/repositories/file_system_repository.dart';
import 'domain/repositories/json_repository.dart';
import 'domain/use_cases/create_temporary_directory_use_case.dart';

void setupFileSystemDependencies() {
  // Register repositories
  sl.registerLazySingleton<FileSystemRepository>(
      () => FileSystemRepositoryImpl());
  sl.registerLazySingleton<JsonRepository>(
      () => JsonRepositoryImpl(sl<FileSystemRepository>()));

  // Register use cases
  sl.registerLazySingleton<CreateTemporaryDirectoryUseCase>(
      () => CreateTemporaryDirectoryUseCase(
            sl<AppPathProvider>(),
            sl<FileSystemRepository>(),
          ));
}
