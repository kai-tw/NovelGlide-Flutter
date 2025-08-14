import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/tts_engine.dart';

class TtsSetVolumeUseCase extends UseCase<Future<void>, double> {
  const TtsSetVolumeUseCase(this._ttsEngine);

  final TtsEngine _ttsEngine;

  @override
  Future<void> call(double parameter) {
    return _ttsEngine.setVolume(parameter);
  }
}
