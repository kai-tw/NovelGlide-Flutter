import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_global_cubit/app_global_cubit.dart';
import '../../core/utils/preference_enum_utils.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../preference_keys/preference_keys.dart';
import '../settings_page/settings_card.dart';

part 'presentation/appearance_settings_dark_mode_card/appearance_settings_dark_mode_card.dart';
part 'presentation/appearance_settings_page/appearance_settings_page.dart';

class AppearanceServices {
  AppearanceServices._();

  static ThemeMode _themeMode = ThemeMode.system;

  static ThemeMode get themeMode => _themeMode;

  static Future<void> ensureInitialized() async {
    _themeMode = await _getThemeMode();
  }

  static Future<ThemeMode> _getThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int index = PreferenceEnumUtils.getEnumIndex(prefs, PreferenceKeys.themeMode) ?? ThemeMode.system.index;
    return ThemeMode.values[index];
  }

  static Future<void> setThemeMode(ThemeMode themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeMode = themeMode;

    prefs.setInt(PreferenceKeys.themeMode, themeMode.index);

    AppGlobalCubit.refreshState();
  }
}
