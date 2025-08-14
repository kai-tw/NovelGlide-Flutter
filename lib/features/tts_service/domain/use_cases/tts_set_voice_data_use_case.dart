import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/tts_voice_data.dart';
import '../repositories/tts_engine.dart';

class TtsSetVoiceDataUseCase extends UseCase<Future<void>, TtsVoiceData?> {
  const TtsSetVoiceDataUseCase(this._ttsEngine);

  final TtsEngine _ttsEngine;

  @override
  Future<void> call(TtsVoiceData? parameter) {
    return _ttsEngine.setVoiceData(parameter);
  }
}
