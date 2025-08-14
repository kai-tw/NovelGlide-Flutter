import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/tts_engine.dart';

class TtsResumeUseCase extends UseCase<Future<void>, void> {
  const TtsResumeUseCase(this._ttsEngine);

  final TtsEngine _ttsEngine;

  @override
  Future<void> call([void parameter]) {
    return _ttsEngine.resume();
  }
}
