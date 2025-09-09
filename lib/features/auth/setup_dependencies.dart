import '../../main.dart';
import 'data/data_sources/auth_api.dart';
import 'data/data_sources/impl/google_auth_api.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/entities/auth_providers.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/use_cases/auth_is_sign_in_use_case.dart';
import 'domain/use_cases/auth_sign_in_use_case.dart';
import 'domain/use_cases/auth_sign_out_use_case.dart';

void setupAuthDependencies() {
  // Register data sources
  sl.registerLazySingleton<GoogleAuthApi>(
    () => GoogleAuthApi(),
  );

  // Register the AuthApi contract with a factory
  sl.registerFactoryParam<AuthApi, AuthProviders, void>(
    (AuthProviders provider, _) => switch (provider) {
      AuthProviders.google => sl<GoogleAuthApi>(),
    },
  );

  // Register repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );

  // Register use cases
  sl.registerFactory<AuthIsSignInUseCase>(
    () => AuthIsSignInUseCase(sl<AuthRepository>()),
  );
  sl.registerFactory<AuthSignInUseCase>(
    () => AuthSignInUseCase(sl<AuthRepository>()),
  );
  sl.registerFactory<AuthSignOutUseCase>(
    () => AuthSignOutUseCase(sl<AuthRepository>()),
  );
}
