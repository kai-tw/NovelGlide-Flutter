import 'package:get_it/get_it.dart';
import 'package:novel_glide/features/appearance/data/data_sources/appearance_local_data_source.dart';
import 'package:novel_glide/features/appearance/data/repositories/appearance_repository_impl.dart';
import 'package:novel_glide/features/appearance/domain/repositories/appearance_repository.dart';
import 'package:novel_glide/features/appearance/domain/use_cases/get_appearance_settings_use_case.dart';
import 'package:novel_glide/features/appearance/domain/use_cases/save_appearance_settings_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setupAppearanceDependencies(
  GetIt getIt,
  SharedPreferences prefs,
) async {
  getIt.registerLazySingleton<AppearanceLocalDataSource>(
    () => AppearanceLocalDataSourceImpl(prefs: prefs),
  );

  getIt.registerLazySingleton<AppearanceRepository>(
    () => AppearanceRepositoryImpl(
        localDataSource: getIt<AppearanceLocalDataSource>()),
  );

  getIt.registerFactory<GetAppearanceSettingsUseCase>(
    () => GetAppearanceSettingsUseCase(getIt<AppearanceRepository>()),
  );

  getIt.registerFactory<SaveAppearanceSettingsUseCase>(
    () => SaveAppearanceSettingsUseCase(getIt<AppearanceRepository>()),
  );
}
