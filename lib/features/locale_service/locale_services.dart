import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/utils/datetime_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/presentation/app_global_cubit/app_global_cubit.dart';
import '../../core/services/preference_service/preference_service.dart';
import '../../generated/i18n/app_localizations.dart';

part 'presentation/locale_settings_page/locale_settings_list.dart';
part 'presentation/locale_settings_page/locale_settings_page.dart';

class LocaleServices {
  LocaleServices._();

  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

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

  static String languageNameOf(BuildContext context, Locale locale) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return switch (locale) {
      const Locale('en') => appLocalizations.languageCodeEnUS,
      const Locale('zh') => appLocalizations.languageCodeZhTW,
      const Locale.fromSubtags(
            languageCode: 'zh', countryCode: 'CN', scriptCode: 'Hans') =>
        appLocalizations.languageCodeZhCN,
      const Locale('ja') => appLocalizations.languageCodeJaJP,
      _ => locale.toLanguageTag(),
    };
  }

  static String? dateTimeOf(BuildContext context, DateTime? dateTime) {
    return dateTime
        ?.format(AppLocalizations.of(context)!.generalDatetimeFormat);
  }
}
