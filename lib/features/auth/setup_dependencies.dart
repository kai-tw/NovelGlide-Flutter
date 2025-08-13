import '../../main.dart';
import 'data/data_sources/auth_api.dart';
import 'data/data_sources/impl/google_auth_api.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/entities/auth_providers.dart';
import 'domain/repositories/auth_repository.dart';

void setupAuthDependencies() {
  // Register data sources
  sl.registerLazySingleton<GoogleAuthApi>(() => GoogleAuthApi());

  // Register the AuthApi contract with a factory
  sl.registerFactoryParam<AuthApi, AuthProviders, void>(
    (AuthProviders provider, _) {
      return switch (provider) {
        AuthProviders.google => sl<GoogleAuthApi>(),
      };
    },
  );

  // Register repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
}
