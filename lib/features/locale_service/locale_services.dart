import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/utils/datetime_extension.dart';

import '../../core/presentation/app_global_cubit/app_global_cubit.dart';
import '../../core/services/preference_service/preference_service.dart';
import '../../generated/i18n/app_localizations.dart';

part 'presentation/locale_settings_page/locale_settings_list.dart';
part 'presentation/locale_settings_page/locale_settings_page.dart';

class LocaleServices {
  LocaleServices._();

  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  static Future<void> ensureInitialized() async {
    _data = await PreferenceService.locale.load();
  }

  static LocalePreferenceData? _data;

  static Locale? get userLocale => _data?.userLocale;

  static set userLocale(Locale? locale) {
    _data = LocalePreferenceData(userLocale: locale);

    // Save the preference
    PreferenceService.locale.save(_data!);
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
