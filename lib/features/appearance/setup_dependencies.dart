import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'data/data_sources/appearance_local_data_source.dart';
import 'data/repositories/appearance_repository_impl.dart';
import 'domain/repositories/appearance_repository.dart';
import 'domain/use_cases/get_appearance_settings_use_case.dart';
import 'domain/use_cases/save_appearance_settings_use_case.dart';

void setupAppearanceDependencies(SharedPreferences prefs) {
  // Register local data source
  sl.registerLazySingleton<AppearanceLocalDataSource>(
    () => AppearanceLocalDataSourceImpl(prefs),
  );

  // Register repository
  sl.registerLazySingleton<AppearanceRepository>(
    () => AppearanceRepositoryImpl(
      localDataSource: sl<AppearanceLocalDataSource>(),
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
