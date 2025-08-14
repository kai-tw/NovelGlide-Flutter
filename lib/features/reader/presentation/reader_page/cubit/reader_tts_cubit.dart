import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../tts_service/domain/entities/tts_state_code.dart';
import '../../../../tts_service/domain/use_cases/tts_observe_state_changed_use_case.dart';
import '../../../../tts_service/domain/use_cases/tts_pause_use_case.dart';
import '../../../../tts_service/domain/use_cases/tts_reload_preference_use_case.dart';
import '../../../../tts_service/domain/use_cases/tts_resume_use_case.dart';
import '../../../../tts_service/domain/use_cases/tts_speak_use_case.dart';
import '../../../../tts_service/domain/use_cases/tts_stop_use_case.dart';
import '../../../domain/use_cases/reader_observe_tts_end_use_case.dart';
import '../../../domain/use_cases/reader_observe_tts_play_use_case.dart';
import '../../../domain/use_cases/reader_observe_tts_stop_use_case.dart';
import '../../../domain/use_cases/reader_send_tts_next_use_case.dart';
import '../../../domain/use_cases/reader_send_tts_play_use_case.dart';
import '../../../domain/use_cases/reader_send_tts_stop_use_case.dart';
import 'reader_tts_state.dart';

class ReaderTtsCubit extends Cubit<ReaderTtsState> {
  ReaderTtsCubit(
    this._readerSendTtsNextUseCase,
    this._readerSendTtsPlayUseCase,
    this._readerSendTtsStopUseCase,
    this._readerObserveTtsEndUseCase,
    this._readerObserveTtsPlayUseCase,
    this._readerObserveTtsStopUseCase,
    this._ttsReloadPreferenceUseCase,
    this._ttsObserveStateChangedUseCase,
    this._ttsSpeakUseCase,
    this._ttsStopUseCase,
    this._ttsPauseUseCase,
    this._ttsResumeUseCase,
  ) : super(const ReaderTtsState());

  /// Communication use cases
  final ReaderSendTtsNextUseCase _readerSendTtsNextUseCase;
  final ReaderSendTtsPlayUseCase _readerSendTtsPlayUseCase;
  final ReaderSendTtsStopUseCase _readerSendTtsStopUseCase;
  final ReaderObserveTtsEndUseCase _readerObserveTtsEndUseCase;
  final ReaderObserveTtsPlayUseCase _readerObserveTtsPlayUseCase;
  final ReaderObserveTtsStopUseCase _readerObserveTtsStopUseCase;

  /// TTS use cases
  final TtsReloadPreferenceUseCase _ttsReloadPreferenceUseCase;
  final TtsObserveStateChangedUseCase _ttsObserveStateChangedUseCase;
  final TtsSpeakUseCase _ttsSpeakUseCase;
  final TtsStopUseCase _ttsStopUseCase;
  final TtsPauseUseCase _ttsPauseUseCase;
  final TtsResumeUseCase _ttsResumeUseCase;

  /// Stream subscription
  late final StreamSubscription<void> _ttsEndStreamSubscription;
  late final StreamSubscription<String> _ttsPlayStreamSubscription;
  late final StreamSubscription<void> _ttsStopStreamSubscription;
  late final StreamSubscription<TtsStateCode>
      _ttsStateChangedStreamSubscription;

  bool isSpeakingEnd = false;

  Future<void> startLoading() async {
    // Listen streams
    _ttsEndStreamSubscription = _readerObserveTtsEndUseCase().listen(_ttsEnd);
    _ttsPlayStreamSubscription =
        _readerObserveTtsPlayUseCase().listen(_ttsPlay);
    _ttsStopStreamSubscription =
        _readerObserveTtsStopUseCase().listen(_ttsStop);
    _ttsStateChangedStreamSubscription =
        _ttsObserveStateChangedUseCase().listen(_onTtsStateChanged);

    // Reload TTS
    await _ttsReloadPreferenceUseCase();
  }

  void _onTtsStateChanged(TtsStateCode code) {
    print(code);

    switch (code) {
      case TtsStateCode.completed:
        if (isSpeakingEnd) {
          emit(ReaderTtsState(ttsState: code));
        } else {
          // The current sentence has been said. Go to next sentence.
          _readerSendTtsNextUseCase();
        }
        break;

      default:
        emit(ReaderTtsState(ttsState: code));
    }
  }

  void sendPlaySignal() {
    isSpeakingEnd = false;
    _readerSendTtsPlayUseCase();
  }

  void resumeSpeaking() {
    _ttsResumeUseCase();
  }

  void pauseSpeaking() {
    _ttsPauseUseCase();
  }

  void stopSpeaking() {
    _ttsStopUseCase();
    _readerSendTtsStopUseCase();
  }

  /// Request to play TTS
  void _ttsPlay(String text) {
    _ttsSpeakUseCase(text);
  }

  /// Stop TTS
  void _ttsStop(void _) {
    _ttsStopUseCase();
  }

  /// Terminate TTS
  void _ttsEnd(void _) {
    isSpeakingEnd = true;
    _ttsStopUseCase();
  }

  @override
  Future<void> close() async {
    await _ttsEndStreamSubscription.cancel();
    await _ttsPlayStreamSubscription.cancel();
    await _ttsStopStreamSubscription.cancel();
    await _ttsStateChangedStreamSubscription.cancel();
    await _ttsStopUseCase();
    super.close();
  }
}
