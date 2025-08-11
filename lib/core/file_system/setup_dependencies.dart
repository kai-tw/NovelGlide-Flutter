import '../../main.dart';
import '../path_provider/domain/repositories/app_path_provider.dart';
import 'data/repositories/file_system_repository_impl.dart';
import 'data/repositories/json_repository_impl.dart';
import 'data/repositories/temp_repository_impl.dart';
import 'domain/repositories/file_system_repository.dart';
import 'domain/repositories/json_repository.dart';
import 'domain/repositories/temp_repository.dart';

void setupFileSystemDependencies() {
  // Register repositories
  sl.registerLazySingleton<FileSystemRepository>(
      () => FileSystemRepositoryImpl());
  sl.registerLazySingleton<JsonRepository>(
      () => JsonRepositoryImpl(sl<FileSystemRepository>()));
  sl.registerLazySingleton<TempRepository>(() => TempRepositoryImpl(
        sl<AppPathProvider>(),
        sl<FileSystemRepository>(),
      ));
}
