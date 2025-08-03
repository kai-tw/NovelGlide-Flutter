import 'package:shared_preferences/shared_preferences.dart';

import '../app/cubit/app_cubit.dart';
import '../features/appearance/domain/use_cases/get_appearance_settings_use_case.dart';
import '../features/appearance/domain/use_cases/save_appearance_settings_use_case.dart';
import '../features/appearance/setup_dependencies.dart';
import '../features/locale/domain/use_cases/get_locale_settings_use_case.dart';
import '../features/locale/domain/use_cases/save_locale_settings_use_case.dart';
import '../features/locale/setup_dependencies.dart';
import '../main.dart';

Future<void> setupDependencies() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Dependencies injection for all features
  setupAppearanceDependencies(prefs);
  setupLocaleDependencies(prefs);

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
