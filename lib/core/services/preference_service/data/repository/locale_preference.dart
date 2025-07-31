part of '../../preference_service.dart';

class LocalePreference extends PreferenceRepository<LocalePreferenceData> {
  final String _localeKey = 'userLocale';

  @override
  Future<LocalePreferenceData> load() async {
    final String? localeString = await tryGetString(_localeKey);
    return LocalePreferenceData(
      userLocale: localeString == null ? null : Locale(localeString),
    );
  }

  @override
  Future<void> reset() async {
    await Future.wait(<Future<void>>[
      remove(_localeKey),
    ]);

    // Notify listeners
    onChangedController.add(null);
  }

  @override
  Future<void> save(LocalePreferenceData data) async {
    await Future.wait(<Future<void>>[
      data.userLocale == null
          ? remove(_localeKey)
          : setString(_localeKey, data.userLocale!.toLanguageTag()),
    ]);

    // Notify listeners
    onChangedController.add(null);
  }
}
