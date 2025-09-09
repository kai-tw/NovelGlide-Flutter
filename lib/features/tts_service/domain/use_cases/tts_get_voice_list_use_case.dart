import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/tts_voice_data.dart';
import '../repositories/tts_engine.dart';

class TtsGetVoiceListUseCase extends UseCase<Future<List<TtsVoiceData>>, void> {
  const TtsGetVoiceListUseCase(this._ttsEngine);

  final TtsEngine _ttsEngine;

  @override
  Future<List<TtsVoiceData>> call([void parameter]) {
    return _ttsEngine.voiceList;
  }
}
