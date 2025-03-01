import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/tts_service_state.dart';
import '../../../services/tts_service.dart';

part 'tts_settings_state.dart';

class TtsSettingsCubit extends Cubit<TtsSettingsState> {
  late final TtsService _ttsService;
  final controller = TextEditingController();

  factory TtsSettingsCubit() => TtsSettingsCubit._().._init();
  TtsSettingsCubit._() : super(const TtsSettingsState());

  void _init() {
    _ttsService = TtsService(onReady: _onReady);
  }

  void _onReady() async {
    _ttsService.setStartHandler(_onSpeakStart);
    _ttsService.setCompletionHandler(_onSpeakEnd);
    _ttsService.setPauseHandler(_onSpeakPause);
    _ttsService.setCancelHandler(_onSpeakEnd);
    _ttsService.setContinueHandler(_onSpeakContinue);
    _ttsService.setErrorHandler(_onSpeakEnd);

    final dataList = await _ttsService.getDataList();
    if (!isClosed) {
      emit(state.copyWith(
        ttsState: TtsServiceState.stopped,
        languageList: dataList,
        pitch: _ttsService.pitch,
        volume: _ttsService.volume,
        speechRate: _ttsService.speechRate,
        languageCode: _ttsService.languageCode,
      ));
    }
  }

  void play() async {
    switch (state.ttsState) {
      case TtsServiceState.paused:
        await _ttsService.resume();
        break;
      case TtsServiceState.stopped:
        final text = controller.text;
        if (text.isNotEmpty) {
          await _ttsService.speak(text);
        }
        break;
      default:
    }
  }

  void pause() async {
    await _ttsService.pause();
  }

  void stop() async {
    await _ttsService.stop();
  }

  void reset() {
    setPitch(TtsService.defaultPitch, true);
    setVolume(TtsService.defaultVolume, true);
    setSpeechRate(TtsService.defaultSpeedRate, true);
  }

  @override
  Future<void> close() async {
    _ttsService.stop();
    controller.dispose();
    super.close();
  }

  void setPitch(double pitch, bool isEnd) {
    if (isClosed) return;
    emit(state.copyWith(pitch: pitch));
    if (isEnd) {
      _ttsService.pitch = pitch;
    }
  }

  void setVolume(double volume, bool isEnd) {
    if (isClosed) return;
    emit(state.copyWith(volume: volume));
    if (isEnd) {
      _ttsService.volume = volume;
    }
  }

  void setSpeechRate(double speechRate, bool isEnd) {
    if (isClosed) return;
    emit(state.copyWith(speechRate: speechRate));
    if (isEnd) {
      _ttsService.speechRate = speechRate;
    }
  }

  void setLanguageCode(String languageCode) {
    if (isClosed) return;
    emit(state.copyWith(languageCode: languageCode));
    _ttsService.languageCode = languageCode;
  }

  void _onSpeakStart() {
    if (!isClosed) emit(state.copyWith(ttsState: TtsServiceState.playing));
  }

  void _onSpeakPause() {
    if (!isClosed) emit(state.copyWith(ttsState: TtsServiceState.paused));
  }

  void _onSpeakContinue() {
    if (!isClosed) emit(state.copyWith(ttsState: TtsServiceState.continued));
  }

  void _onSpeakEnd([_]) {
    if (!isClosed) emit(state.copyWith(ttsState: TtsServiceState.stopped));
  }
}
