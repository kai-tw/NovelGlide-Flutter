import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'data/data_sources/locale_local_data_source.dart';
import 'data/repositories/locale_repository_impl.dart';
import 'domain/repositories/locale_repository.dart';
import 'domain/use_cases/get_locale_settings_use_case.dart';
import 'domain/use_cases/save_locale_settings_use_case.dart';

Future<void> setupLocaleDependencies(SharedPreferences prefs) async {
  // Register local data source
  sl.registerLazySingleton<LocaleLocalDataSource>(
    () => LocaleLocalDataSourceImpl(prefs),
  );

  // Register repository
  sl.registerLazySingleton<LocaleRepository>(
    () => LocaleRepositoryImpl(
      localDataSource: sl<LocaleLocalDataSource>(),
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
