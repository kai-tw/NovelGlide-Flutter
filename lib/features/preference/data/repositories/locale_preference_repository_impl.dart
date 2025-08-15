import 'dart:async';

import '../../../locale_system/domain/entities/app_locale.dart';
import '../../domain/entities/locale_preference_data.dart';
import '../../domain/entities/preference_keys.dart';
import '../../domain/repositories/preference_repository.dart';
import '../data_sources/preference_local_data_source.dart';

class LocalePreferenceRepositoryImpl implements LocalePreferenceRepository {
  LocalePreferenceRepositoryImpl(
    this._localDataSource,
  );

  final PreferenceLocalDataSource _localDataSource;
  final StreamController<LocalePreferenceData> _onChangedController =
      StreamController<LocalePreferenceData>.broadcast();

  @override
  Future<LocalePreferenceData> getPreference() async {
    // Load the preference of locale.
    final String? localeString =
        await _localDataSource.tryGetString(PreferenceKeys.appLocale);

    return LocalePreferenceData(
      userLocale:
          localeString == null ? null : AppLocale.fromString(localeString),
    );
  }

  @override
  Future<void> savePreference(LocalePreferenceData data) async {
    if (data.userLocale == null) {
      await _localDataSource.remove(PreferenceKeys.appLocale);
    } else {
      await _localDataSource.setString(
          PreferenceKeys.appLocale, data.userLocale.toString());
    }

    _onChangedController.add(data);
  }

  @override
  Stream<LocalePreferenceData> get onChangedStream =>
      _onChangedController.stream;

  @override
  Future<void> resetPreference() async {
    await _localDataSource.remove(PreferenceKeys.appLocale);

    _onChangedController.add(const LocalePreferenceData());
  }
}
