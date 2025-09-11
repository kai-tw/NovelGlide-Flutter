import '../../core/http_client/domain/use_cases/http_client_get_use_case.dart';
import '../../main.dart';
import 'presentation/cubit/shared_manual_cubit.dart';

void setupManualDependencies() {
  // Register cubits
  sl.registerFactory<SharedManualCubit>(
    () => SharedManualCubit(
      sl<HttpClientGetUseCase>(),
    ),
  );
}
