import 'package:shared_preferences/shared_preferences.dart';

import '../app/cubit/app_cubit.dart';
import '../features/advertisement/setup_dependencies.dart';
import '../features/appearance/setup_dependencies.dart';
import '../features/auth/setup_dependencies.dart';
import '../features/backup/setup_dependencies.dart';
import '../features/bookmark/setup_dependencies.dart';
import '../features/books/setup_dependencies.dart';
import '../features/cloud/setup_dependencies.dart';
import '../features/collection/setup_dependencies.dart';
import '../features/locale_system/setup_dependencies.dart';
import '../features/pick_file/setup_dependencies.dart';
import '../features/preference/domain/use_cases/preference_get_use_cases.dart';
import '../features/preference/domain/use_cases/preference_observe_change_use_case.dart';
import '../features/preference/domain/use_cases/preference_save_use_case.dart';
import '../features/preference/setup_dependencies.dart';
import '../features/reader/setup_dependencies.dart';
import '../features/tts_service/setup_dependencies.dart';
import '../main.dart';
import 'file_system/setup_dependencies.dart';
import 'log_system/setup_dependencies.dart';
import 'mime_resolver/setup_dependencies.dart';
import 'path_provider/setup_dependencies.dart';

Future<void> setupDependencies() async {
  // Shared instances
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Setup the core function
  setupPathProviderDependencies();
  setupFileSystemDependencies();

  // Dependencies injection for all features
  setupAdDependencies();
  setupAppearanceDependencies();
  setupAuthDependencies();
  setupBackupDependencies();
  setupBookDependencies();
  setupBookmarkDependencies();
  setupCollectionDependencies();
  setupCloudDependencies();
  setupLocaleDependencies();
  setupLogDependencies();
  setupMimeResolverDependencies();
  setupPickFileDependencies();
  setupPreferenceDependencies(prefs);
  setupReaderDependencies();
  setupTtsDependencies();

  // Dependencies injection for app
  sl.registerSingletonAsync<AppCubit>(() async {
    final AppCubit cubit = AppCubit(
      sl<AppearanceGetPreferenceUseCase>(),
      sl<AppearanceSavePreferenceUseCase>(),
      sl<AppearanceObservePreferenceChangeUseCase>(),
      sl<LocaleGetPreferenceUseCase>(),
      sl<LocaleSavePreferenceUseCase>(),
      sl<LocaleObservePreferenceChangeUseCase>(),
    );
    await cubit.init();
    return cubit;
  });
}
