import '../entities/tts_state_code.dart';
import '../entities/tts_voice_data.dart';

abstract class TtsEngine {
  Stream<TtsStateCode> get stateChangedStream;

  Future<List<TtsVoiceData>> get voiceList;

  Future<void> setPitch(double pitch);

  Future<void> setVolume(double volume);

  Future<void> setSpeechRate(double speechRate);

  Future<void> setVoiceData(TtsVoiceData? voiceData);

  Future<void> reloadPreference();

  Future<void> reset();

  Future<void> speak(String text);

  Future<void> pause();

  Future<void> resume();

  Future<void> stop();
}
