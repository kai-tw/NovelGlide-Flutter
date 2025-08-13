import '../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../core/mime_resolver/domain/repositories/mime_repository.dart';
import '../../main.dart';
import '../auth/domain/repositories/auth_repository.dart';
import 'data/data_sources/cloud_drive_api.dart';
import 'data/data_sources/impl/google_drive_api.dart';
import 'data/repositories/cloud_repository_impl.dart';
import 'domain/entities/cloud_providers.dart';
import 'domain/repositories/cloud_repository.dart';

void setupCloudDependencies() {
  // Register data sources
  sl.registerLazySingleton<GoogleDriveApi>(() => GoogleDriveApi(
        sl<AuthRepository>(),
        sl<FileSystemRepository>(),
        sl<MimeRepository>(),
      ));

  // Register CloudDriveApi contract with a factory
  sl.registerFactoryParam<CloudDriveApi, CloudProviders, void>(
    (CloudProviders provider, _) => switch (provider) {
      CloudProviders.google => sl<GoogleDriveApi>(),
    },
  );

  // Register repositories
  sl.registerLazySingleton<CloudRepository>(() => CloudRepositoryImpl());
}
