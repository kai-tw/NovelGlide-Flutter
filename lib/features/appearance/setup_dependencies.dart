import '../../main.dart';
import '../preference/domain/repositories/preference_repository.dart';
import 'data/repositories/appearance_repository_impl.dart';
import 'domain/repositories/appearance_repository.dart';
import 'domain/use_cases/get_appearance_settings_use_case.dart';
import 'domain/use_cases/save_appearance_settings_use_case.dart';

void setupAppearanceDependencies() {
  // Register repository
  sl.registerLazySingleton<AppearanceRepository>(
    () => AppearanceRepositoryImpl(
      sl<PreferenceRepository>(),
    ),
  );

  // Register use cases
  sl.registerFactory<GetAppearanceSettingsUseCase>(
    () => GetAppearanceSettingsUseCase(sl<AppearanceRepository>()),
  );

  sl.registerFactory<SaveAppearanceSettingsUseCase>(
    () => SaveAppearanceSettingsUseCase(sl<AppearanceRepository>()),
  );
}
