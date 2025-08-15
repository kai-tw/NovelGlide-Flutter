import '../../main.dart';
import '../preference/domain/repositories/preference_repository.dart';
import '../preference/domain/use_cases/preference_get_use_cases.dart';
import 'domain/use_cases/appearance_observe_preference_change_use_case.dart';
import 'domain/use_cases/appearance_save_preference_use_case.dart';

void setupAppearanceDependencies() {
  // Register use cases
  sl.registerFactory<AppearanceGetPreferenceUseCase>(
    () => AppearanceGetPreferenceUseCase(sl<AppearancePreferenceRepository>()),
  );
  sl.registerFactory<AppearanceObservePreferenceChangeUseCase>(
    () => AppearanceObservePreferenceChangeUseCase(
        sl<AppearancePreferenceRepository>()),
  );
  sl.registerFactory<AppearanceSavePreferenceUseCase>(
    () => AppearanceSavePreferenceUseCase(sl<AppearancePreferenceRepository>()),
  );
}
