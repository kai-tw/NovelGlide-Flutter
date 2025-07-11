import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_global_cubit/app_global_cubit.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../preference_keys/preference_keys.dart';

part 'presentation/locale_settings_page/cubit/locale_settings_cubit.dart';
part 'presentation/locale_settings_page/cubit/locale_settings_state.dart';
part 'presentation/locale_settings_page/locale_settings_list.dart';
part 'presentation/locale_settings_page/locale_settings_page.dart';

class LocaleServices {
  LocaleServices._();

  static Locale? _userLocale;

  static Locale? get userLocale => _userLocale;

  static Future<void> ensureInitialized() async {
    _userLocale = await LocaleServices._getUserLocale();
  }

  static Future<Locale?> _getUserLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(PreferenceKeys.userLocale);
    return languageCode == null ? null : Locale(languageCode);
  }

  static Future<void> setUserLocale(Locale? locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _userLocale = locale;

    if (locale == null) {
      prefs.remove(PreferenceKeys.userLocale);
    } else {
      prefs.setString(PreferenceKeys.userLocale, locale.toLanguageTag());
    }

    AppGlobalCubit.refreshState();
  }
}
