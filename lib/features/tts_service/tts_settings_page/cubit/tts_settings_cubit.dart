part of '../../tts_service.dart';

class TtsSettingsCubit extends Cubit<TtsSettingsState> {
  factory TtsSettingsCubit() => TtsSettingsCubit._().._init();

  TtsSettingsCubit._() : super(const TtsSettingsState());
  late final TtsService _ttsService;
  final TextEditingController controller = TextEditingController();

  void _init() {
    _ttsService = TtsService(onReady: _onReady);
  }

  Future<void> _onReady() async {
    _ttsService.setStartHandler(_onSpeakStart);
    _ttsService.setCompletionHandler(_onSpeakEnd);
    _ttsService.setPauseHandler(_onSpeakPause);
    _ttsService.setCancelHandler(_onSpeakEnd);
    _ttsService.setContinueHandler(_onSpeakContinue);
    _ttsService.setErrorHandler(_onSpeakEnd);

    final List<TtsVoiceData> dataList = await _ttsService.voiceList;
    if (!isClosed) {
      emit(state.copyWith(
        ttsState: TtsServiceState.stopped,
        voiceList: dataList,
        pitch: _ttsService.pitch,
        volume: _ttsService.volume,
        speechRate: _ttsService.speechRate,
        voiceData: _ttsService.voiceData,
      ));
    }
  }

  Future<void> play() async {
    switch (state.ttsState) {
      case TtsServiceState.paused:
        await _ttsService.resume();
        break;

      case TtsServiceState.stopped:
        final String text = controller.text;

        emit(state.copyWith(isTextEmpty: text.isEmpty));

        if (text.isNotEmpty) {
          await _ttsService.speak(text);
        }
        break;

      default:
    }
  }

  Future<void> pause() async {
    await _ttsService.pause();
  }

  Future<void> stop() async {
    await _ttsService.stop();
  }

  void reset() {
    _ttsService.reset();
    emit(state.copyWith(
      pitch: _ttsService.pitch,
      volume: _ttsService.volume,
      speechRate: _ttsService.speechRate,
      voiceData: _ttsService.voiceData,
      isVoiceNull: true,
    ));
  }

  @override
  Future<void> close() async {
    _ttsService.stop();
    controller.dispose();
    super.close();
  }

  void setPitch(double pitch, bool isEnd) {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(pitch: pitch));
    if (isEnd) {
      _ttsService.pitch = pitch;
    }
  }

  void setVolume(double volume, bool isEnd) {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(volume: volume));
    if (isEnd) {
      _ttsService.volume = volume;
    }
  }

  void setSpeechRate(double speechRate, bool isEnd) {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(speechRate: speechRate));
    if (isEnd) {
      _ttsService.speechRate = speechRate;
    }
  }

  void setVoiceData(TtsVoiceData voiceData) {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(voiceData: voiceData));
    _ttsService.voiceData = voiceData;
  }

  void _onSpeakStart() {
    if (!isClosed) {
      emit(state.copyWith(ttsState: TtsServiceState.playing));
    }
  }

  void _onSpeakPause() {
    if (!isClosed) {
      emit(state.copyWith(ttsState: TtsServiceState.paused));
    }
  }

  void _onSpeakContinue() {
    if (!isClosed) {
      emit(state.copyWith(ttsState: TtsServiceState.continued));
    }
  }

  void _onSpeakEnd([dynamic _]) {
    if (!isClosed) {
      emit(state.copyWith(ttsState: TtsServiceState.stopped));
    }
  }
}
