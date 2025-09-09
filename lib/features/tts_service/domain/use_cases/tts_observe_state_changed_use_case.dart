import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/tts_state_code.dart';
import '../repositories/tts_engine.dart';

class TtsObserveStateChangedUseCase
    extends UseCase<Stream<TtsStateCode>, void> {
  const TtsObserveStateChangedUseCase(this._ttsEngine);

  final TtsEngine _ttsEngine;

  @override
  Stream<TtsStateCode> call([void parameter]) {
    return _ttsEngine.stateChangedStream;
  }
}
