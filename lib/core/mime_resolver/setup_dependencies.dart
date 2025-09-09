import '../../main.dart';
import '../file_system/domain/repositories/file_system_repository.dart';
import 'data/data_sources/impl/mime_local_source_impl.dart';
import 'data/data_sources/mime_local_source.dart';
import 'data/repositories/mime_repository_impl.dart';
import 'domain/repositories/mime_repository.dart';

void setupMimeResolverDependencies() {
  // Register data sources
  sl.registerLazySingleton<MimeLocalSource>(() => MimeLocalSourceImpl(
        sl<FileSystemRepository>(),
      ));

  // Register repositories
  sl.registerLazySingleton<MimeRepository>(() => MimeRepositoryImpl(
        sl<MimeLocalSource>(),
      ));
}
