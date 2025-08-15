import '../../main.dart';
import '../preference/domain/repositories/preference_repository.dart';
import '../preference/domain/use_cases/preference_get_use_cases.dart';
import 'domain/use_cases/locale_observe_preference_change_use_case.dart';
import 'domain/use_cases/locale_save_preference_use_case.dart';

void setupLocaleDependencies() {
  // Register use cases
  sl.registerFactory<LocaleGetPreferenceUseCase>(
    () => LocaleGetPreferenceUseCase(sl<LocalePreferenceRepository>()),
  );
  sl.registerFactory<LocaleObservePreferenceChangeUseCase>(
    () =>
        LocaleObservePreferenceChangeUseCase(sl<LocalePreferenceRepository>()),
  );
  sl.registerFactory<LocaleSavePreferenceUseCase>(
    () => LocaleSavePreferenceUseCase(sl<LocalePreferenceRepository>()),
  );
}
