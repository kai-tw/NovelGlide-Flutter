import 'dart:io';

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

  static Locale get currentLocale => userLocale ?? Locale(Platform.localeName);

  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  static List<Locale> get supportedLocalesRelativeOrder {
    const List<Locale> supportedLocales = AppLocalizations.supportedLocales;

    // supportedLocales.sort((Locale a, Locale b) {
    //   if (a.languageCode == currentLocale.languageCode) {
    //     return 1;
    //   }
    // });

    return supportedLocales;
  }

  static Future<void> ensureInitialized() async {
    _userLocale = await LocaleServices._getUserLocale();
  }

  static Locale? _userLocale;

  static Locale? get userLocale => _userLocale;

  static set userLocale(Locale? locale) {
    _userLocale = locale;
    AppGlobalCubit.refreshState();

    // Save preferences
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      if (locale == null) {
        prefs.remove(PreferenceKeys.userLocale);
      } else {
        prefs.setString(PreferenceKeys.userLocale, locale.toLanguageTag());
      }
    });
  }

  static Future<Locale?> _getUserLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(PreferenceKeys.userLocale);
    return languageCode == null ? null : Locale(languageCode);
  }
}
