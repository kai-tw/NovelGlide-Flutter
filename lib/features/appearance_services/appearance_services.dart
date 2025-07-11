import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_global_cubit/app_global_cubit.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../preference_keys/preference_keys.dart';
import '../settings_page/settings_card.dart';

part 'presentation/appearance_settings_dark_mode_card/appearance_settings_dark_mode_card.dart';
part 'presentation/appearance_settings_dark_mode_card/cubit/appearance_settings_dark_mode_card_cubit.dart';
part 'presentation/appearance_settings_dark_mode_card/cubit/appearance_settings_dark_mode_card_state.dart';
part 'presentation/appearance_settings_page/appearance_settings_page.dart';

class AppearanceServices {
  AppearanceServices._();

  static bool? _isDarkMode;

  static bool? get isDarkMode => _isDarkMode;

  static Future<void> ensureInitialized() async {
    _isDarkMode = await _getDarkMode();
  }

  static Future<bool?> _getDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PreferenceKeys.darkMode);
  }

  static Future<void> setDarkMode(bool? isDarkMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = isDarkMode;

    if (isDarkMode == null) {
      prefs.remove(PreferenceKeys.darkMode);
    } else {
      prefs.setBool(PreferenceKeys.darkMode, isDarkMode);
    }

    AppGlobalCubit.refreshState();
  }
}
