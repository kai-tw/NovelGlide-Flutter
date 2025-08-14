import '../entities/tts_preference_data.dart';

abstract class TtsPreferenceRepository {
  Stream<void> get onChangedStream;

  Future<TtsPreferenceData> getPreference();

  Future<void> save(TtsPreferenceData data);

  Future<void> reset();
}
