import '../entities/appearance_preference_data.dart';
import '../entities/locale_preference_data.dart';
import '../entities/tts_preference_data.dart';

abstract class PreferenceRepository<T> {
  Stream<T> get onChangedStream;

  Future<T> getPreference();

  Future<void> savePreference(T data);

  Future<void> resetPreference();
}

typedef AppearancePreferenceRepository
    = PreferenceRepository<AppearancePreferenceData>;
typedef LocalePreferenceRepository = PreferenceRepository<LocalePreferenceData>;
typedef TtsPreferenceRepository = PreferenceRepository<TtsPreferenceData>;
