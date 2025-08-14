import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/tts_engine.dart';

class TtsSpeakUseCase extends UseCase<Future<void>, String> {
  const TtsSpeakUseCase(this._ttsEngine);

  final TtsEngine _ttsEngine;

  @override
  Future<void> call(String parameter) {
    return _ttsEngine.speak(parameter);
  }
}
