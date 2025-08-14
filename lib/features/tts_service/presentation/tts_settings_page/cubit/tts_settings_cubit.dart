import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tts_state_code.dart';
import '../../../domain/entities/tts_voice_data.dart';
import '../../../domain/use_cases/tts_get_preference_use_case.dart';
import '../../../domain/use_cases/tts_get_voice_list_use_case.dart';
import '../../../domain/use_cases/tts_observe_state_changed_use_case.dart';
import '../../../domain/use_cases/tts_pause_use_case.dart';
import '../../../domain/use_cases/tts_reload_preference_use_case.dart';
import '../../../domain/use_cases/tts_reset_use_case.dart';
import '../../../domain/use_cases/tts_resume_use_case.dart';
import '../../../domain/use_cases/tts_set_pitch_use_case.dart';
import '../../../domain/use_cases/tts_set_speech_rate_use_case.dart';
import '../../../domain/use_cases/tts_set_voice_data_use_case.dart';
import '../../../domain/use_cases/tts_set_volume_use_case.dart';
import '../../../domain/use_cases/tts_speak_use_case.dart';
import '../../../domain/use_cases/tts_stop_use_case.dart';
import 'tts_settings_state.dart';

class TtsSettingsCubit extends Cubit<TtsSettingsState> {
  TtsSettingsCubit(
    this._ttsObserveStateChangedUseCase,
    this._ttsGetVoiceListUseCase,
    this._ttsSpeakUseCase,
    this._ttsResumeUseCase,
    this._ttsStopUseCase,
    this._ttsPauseUseCase,
    this._ttsResetUseCase,
    this._ttsSetPitchUseCase,
    this._ttsSetVolumeUseCase,
    this._ttsSetSpeechRateUseCase,
    this._ttsSetVoiceDataUseCase,
    this._ttsGetPreferenceUseCase,
    this._ttsReloadPreferenceUseCase,
  ) : super(const TtsSettingsState());

  /// Use cases
  final TtsObserveStateChangedUseCase _ttsObserveStateChangedUseCase;
  final TtsGetVoiceListUseCase _ttsGetVoiceListUseCase;
  final TtsSpeakUseCase _ttsSpeakUseCase;
  final TtsResumeUseCase _ttsResumeUseCase;
  final TtsStopUseCase _ttsStopUseCase;
  final TtsPauseUseCase _ttsPauseUseCase;
  final TtsResetUseCase _ttsResetUseCase;
  final TtsSetPitchUseCase _ttsSetPitchUseCase;
  final TtsSetVolumeUseCase _ttsSetVolumeUseCase;
  final TtsSetSpeechRateUseCase _ttsSetSpeechRateUseCase;
  final TtsSetVoiceDataUseCase _ttsSetVoiceDataUseCase;
  final TtsGetPreferenceUseCase _ttsGetPreferenceUseCase;
  final TtsReloadPreferenceUseCase _ttsReloadPreferenceUseCase;

  /// Stream subscription
  late final StreamSubscription<TtsStateCode> _ttsStateSubscription;

  /// Text editing controller
  final TextEditingController controller = TextEditingController();

  Future<void> startLoading() async {
    emit(state.copyWith(
      voiceList: await _ttsGetVoiceListUseCase(),
    ));

    _ttsStateSubscription =
        _ttsObserveStateChangedUseCase().listen((TtsStateCode code) {
      emit(state.copyWith(ttsState: code));
      print(code);
    });

    await _ttsReloadPreferenceUseCase();
  }

  Future<void> play() async {
    final String text = controller.text;
    if (text.isNotEmpty) {
      await _ttsSpeakUseCase(controller.text);
    }
  }

  Future<void> resume() => _ttsResumeUseCase();

  Future<void> pause() => _ttsPauseUseCase();

  Future<void> stop() => _ttsStopUseCase();

  Future<void> reset() async {
    await _ttsStopUseCase();
    await _ttsResetUseCase();

    // Reload preferences data
    emit(state.copyWith(
      data: await _ttsGetPreferenceUseCase(),
    ));
  }

  @override
  Future<void> close() async {
    await _ttsStopUseCase();
    controller.dispose();
    _ttsStateSubscription.cancel();
    super.close();
  }

  Future<void> setPitch(double pitch) async {
    await _ttsSetPitchUseCase(pitch);
    emit(state.copyWith(
      data: state.data.copyWith(
        pitch: pitch,
      ),
    ));
  }

  Future<void> setVolume(double volume) async {
    await _ttsSetVolumeUseCase(volume);
    emit(state.copyWith(
      data: state.data.copyWith(
        volume: volume,
      ),
    ));
  }

  Future<void> setSpeechRate(double speechRate) async {
    await _ttsSetSpeechRateUseCase(speechRate);
    emit(state.copyWith(
      data: state.data.copyWith(
        speechRate: speechRate,
      ),
    ));
  }

  Future<void> setVoiceData(TtsVoiceData voiceData) async {
    await _ttsSetVoiceDataUseCase(voiceData);
    emit(state.copyWith(
      data: state.data.copyWithVoiceData(voiceData),
    ));
  }
}
