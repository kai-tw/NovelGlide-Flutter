import '../../../preference/domain/entities/preference_keys.dart';
import '../../../preference/domain/repositories/preference_repository.dart';
import '../../domain/entities/app_locale.dart';
import '../../domain/entities/locale_settings.dart';
import '../../domain/repositories/locale_repository.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  const LocaleRepositoryImpl(
    this._preferenceRepository,
  );

  final PreferenceRepository _preferenceRepository;

  @override
  Future<LocaleSettings> getLocaleSettings() async {
    // Load the preference of locale.
    final String? localeString =
        await _preferenceRepository.tryGetString(PreferenceKeys.appLocale);

    return LocaleSettings(
      userLocale:
          localeString == null ? null : AppLocale.fromString(localeString),
    );
  }

  @override
  Future<void> saveLocaleSettings(LocaleSettings settings) {
    return _preferenceRepository.setString(
        PreferenceKeys.appLocale, settings.userLocale.toString());
  }
}
