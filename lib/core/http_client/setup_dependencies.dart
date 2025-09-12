import '../../main.dart';
import 'data/repositories/http_client_repository_impl.dart';
import 'domain/repositories/http_client_repository.dart';

void setupHttpClientDependencies() {
  // Register repositories
  sl.registerLazySingleton<HttpClientRepository>(
    () => HttpClientRepositoryImpl(),
  );
}
