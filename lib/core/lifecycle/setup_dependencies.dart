import '../../main.dart';
import 'data/repositories/lifecycle_repository_impl.dart';
import 'domain/repositories/lifecycle_repository.dart';

void setupLifecycleDependencies() {
  // Register repositories
  sl.registerLazySingleton<LifecycleRepository>(
    () => LifecycleRepositoryImpl(),
  );
}
