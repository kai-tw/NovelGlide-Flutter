import '../../main.dart';
import '../preference/domain/repositories/preference_repository.dart';
import 'data/repositories/locale_repository_impl.dart';
import 'domain/repositories/locale_repository.dart';
import 'domain/use_cases/get_locale_settings_use_case.dart';
import 'domain/use_cases/save_locale_settings_use_case.dart';

void setupLocaleDependencies() {
  // Register repository
  sl.registerLazySingleton<LocaleRepository>(
    () => LocaleRepositoryImpl(
      sl<PreferenceRepository>(),
    ),
  );

  // Register use cases
  sl.registerFactory<GetLocaleSettingsUseCase>(
    () => GetLocaleSettingsUseCase(sl<LocaleRepository>()),
  );

  sl.registerFactory<SaveLocaleSettingsUseCase>(
    () => SaveLocaleSettingsUseCase(sl<LocaleRepository>()),
  );
}
