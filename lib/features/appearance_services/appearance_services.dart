import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/presentation/app_global_cubit/app_global_cubit.dart';
import '../../core/services/preference_service/preference_service.dart';
import '../../generated/i18n/app_localizations.dart';
import '../settings_page/settings_service.dart';

part 'data/repository/theme/default_theme.dart';
part 'data/repository/theme/theme_template.dart';
part 'presentation/appearance_settings_dark_mode_card/appearance_settings_dark_mode_card.dart';
part 'presentation/appearance_settings_page/appearance_settings_page.dart';

class AppearanceServices {
  AppearanceServices._();

  static AppearancePreferenceData? _data;

  static Future<void> ensureInitialized() async {
    // Load appearance data before starting app.
    _data = await PreferenceService.appearance.load();
  }

  static ThemeMode get themeMode => _data?.themeMode ?? ThemeMode.system;

  static set themeMode(ThemeMode mode) {
    _data = AppearancePreferenceData(
      themeMode: mode,
    );

    PreferenceService.appearance.save(_data!);
  }

  static ThemeTemplate get theme => const DefaultTheme();
}
