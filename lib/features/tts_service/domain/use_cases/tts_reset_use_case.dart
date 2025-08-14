import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/tts_engine.dart';

class TtsResetUseCase extends UseCase<Future<void>, void> {
  const TtsResetUseCase(this._ttsEngine);

  final TtsEngine _ttsEngine;

  @override
  Future<void> call([void parameter]) {
    return _ttsEngine.reset();
  }
}
