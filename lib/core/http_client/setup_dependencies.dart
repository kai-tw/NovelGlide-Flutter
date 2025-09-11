import '../../main.dart';
import 'data/repositories/http_client_repository_impl.dart';
import 'domain/repositories/http_client_repository.dart';
import 'domain/use_cases/http_client_get_use_case.dart';

void setupHttpClientDependencies() {
  // Register repositories
  sl.registerLazySingleton<HttpClientRepository>(
    () => HttpClientRepositoryImpl(),
  );

  // Register use cases
  sl.registerFactory<HttpClientGetUseCase>(
    () => HttpClientGetUseCase(
      sl<HttpClientRepository>(),
    ),
  );
}
