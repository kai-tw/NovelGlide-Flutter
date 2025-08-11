import 'package:shared_preferences/shared_preferences.dart';

import '../app/cubit/app_cubit.dart';
import '../features/advertisement/setup_dependencies.dart';
import '../features/appearance/domain/use_cases/get_appearance_settings_use_case.dart';
import '../features/appearance/domain/use_cases/save_appearance_settings_use_case.dart';
import '../features/appearance/setup_dependencies.dart';
import '../features/backup_service/setup_dependencies.dart';
import '../features/bookmark/setup_dependencies.dart';
import '../features/books/setup_dependencies.dart';
import '../features/collection/setup_dependencies.dart';
import '../features/locale_system/domain/use_cases/get_locale_settings_use_case.dart';
import '../features/locale_system/domain/use_cases/save_locale_settings_use_case.dart';
import '../features/locale_system/setup_dependencies.dart';
import '../features/reader/setup_dependencies.dart';
import '../main.dart';
import 'file_system/setup_dependencies.dart';
import 'log_system/setup_dependencies.dart';
import 'path_provider/setup_dependencies.dart';

Future<void> setupDependencies() async {
  // Shared instances
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Setup the core function
  setupPathProviderDependencies();
  setupFileSystemDependencies();

  // Dependencies injection for all features
  setupAdDependencies();
  setupAppearanceDependencies(prefs);
  setupBackupDependencies();
  setupLocaleDependencies(prefs);
  setupLogDependencies();
  setupBookDependencies();
  setupBookmarkDependencies();
  setupCollectionDependencies();
  setupReaderDependencies();

  // Dependencies injection for app
  sl.registerSingletonAsync<AppCubit>(() async {
    final AppCubit cubit = AppCubit(
      sl<GetAppearanceSettingsUseCase>(),
      sl<SaveAppearanceSettingsUseCase>(),
      sl<GetLocaleSettingsUseCase>(),
      sl<SaveLocaleSettingsUseCase>(),
    );
    await cubit.init();
    return cubit;
  });
}
