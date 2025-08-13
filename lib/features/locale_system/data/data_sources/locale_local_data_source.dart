import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/shared_preference_extension.dart';
import '../../domain/entities/app_locale.dart';
import '../../domain/entities/locale_settings.dart';

abstract class LocaleLocalDataSource {
  Future<LocaleSettings> getLocaleSettings();

  Future<void> saveLocaleSettings(LocaleSettings settings);
}

class LocaleLocalDataSourceImpl implements LocaleLocalDataSource {
  LocaleLocalDataSourceImpl(this.prefs);

  final SharedPreferences prefs;
  final String _localeKey = 'userLocale';

  @override
  Future<LocaleSettings> getLocaleSettings() async {
    final String? localeString = prefs.tryGetString(_localeKey);
    return LocaleSettings(
      userLocale:
          localeString == null ? null : AppLocale.fromString(localeString),
    );
  }

  @override
  Future<void> saveLocaleSettings(LocaleSettings settings) {
    return Future.wait(<Future<void>>[
      settings.userLocale == null
          ? prefs.remove(_localeKey)
          : prefs.setString(_localeKey, settings.userLocale!.toString()),
    ]);
  }
}
