part of '../../tts_service.dart';

class TtsSettingsCubit extends Cubit<TtsSettingsState> {
  factory TtsSettingsCubit() {
    final TtsSettingsCubit cubit = TtsSettingsCubit._();
    cubit._ttsService = TtsService(onReady: cubit._onReady);
    return cubit;
  }

  TtsSettingsCubit._() : super(const TtsSettingsState());
  late final TtsService _ttsService;
  final TextEditingController controller = TextEditingController();

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
        data: _ttsService.data,
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

  Future<void> reset() async {
    await _ttsService.reset();
    emit(state.copyWith(
      data: _ttsService.data,
    ));
  }

  @override
  Future<void> close() async {
    _ttsService.stop();
    controller.dispose();
    super.close();
  }

  Future<void> setPitch(double pitch) async {
    await _ttsService.setPitch(pitch);
    emit(state.copyWith(data: _ttsService.data));
  }

  Future<void> setVolume(double volume) async {
    await _ttsService.setVolume(volume);
    emit(state.copyWith(data: _ttsService.data));
  }

  Future<void> setSpeechRate(double speechRate) async {
    await _ttsService.setSpeechRate(speechRate);
    emit(state.copyWith(data: _ttsService.data));
  }

  Future<void> setVoiceData(TtsVoiceData voiceData) async {
    await _ttsService.setVoiceData(voiceData);
    emit(state.copyWith(data: _ttsService.data));
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
