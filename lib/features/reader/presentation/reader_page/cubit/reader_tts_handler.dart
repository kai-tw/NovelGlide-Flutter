part of 'reader_cubit.dart';

class ReaderTTSHandler {
  factory ReaderTTSHandler(
    ReaderSendTtsNextUseCase readerSendTtsNextUseCase,
    ReaderSendTtsPlayUseCase readerSendTtsPlayUseCase,
    ReaderSendTtsStopUseCase readerSendTtsStopUseCase,
    ReaderObserveTtsEndUseCase readerObserveTtsEndUseCase,
    ReaderObserveTtsPlayUseCase readerObserveTtsPlayUseCase,
    ReaderObserveTtsStopUseCase readerObserveTtsStopUseCase, {
    required void Function(TtsServiceState state) onTtsStateChanged,
  }) {
    final ReaderTTSHandler handler = ReaderTTSHandler._(
      readerSendTtsNextUseCase,
      readerSendTtsPlayUseCase,
      readerSendTtsStopUseCase,
      onTtsStateChanged,
    );

    handler._ttsService = TtsService(onReady: handler._onReady);
    handler._ttsEndStreamSubscription =
        readerObserveTtsEndUseCase().listen(handler._ttsEnd);
    handler._ttsPlayStreamSubscription =
        readerObserveTtsPlayUseCase().listen(handler._ttsPlay);
    handler._ttsStopStreamSubscription =
        readerObserveTtsStopUseCase().listen(handler._ttsStop);

    return handler;
  }

  ReaderTTSHandler._(
    this._readerSendTtsNextUseCase,
    this._readerSendTtsPlayUseCase,
    this._readerSendTtsStopUseCase,
    this.onTtsStateChanged,
  );

  late TtsService _ttsService;
  final void Function(TtsServiceState state) onTtsStateChanged;

  /// Stream subscription
  late final StreamSubscription<void> _ttsEndStreamSubscription;
  late final StreamSubscription<String> _ttsPlayStreamSubscription;
  late final StreamSubscription<void> _ttsStopStreamSubscription;

  /// Use cases
  final ReaderSendTtsNextUseCase _readerSendTtsNextUseCase;
  final ReaderSendTtsPlayUseCase _readerSendTtsPlayUseCase;
  final ReaderSendTtsStopUseCase _readerSendTtsStopUseCase;

  bool isPaused = false;
  bool isCanceled = false;

  void reload() {
    _ttsService = TtsService(onReady: _onReady);
  }

  /// Events

  /// TTS service is ready
  void _onReady() {
    onTtsStateChanged(TtsServiceState.stopped);

    _ttsService.setStartHandler(_onPlaying);
    _ttsService.setPauseHandler(_onPaused);
    _ttsService.setCompletionHandler(_onComplete);
    _ttsService.setCancelHandler(_onCancel);
    _ttsService.setContinueHandler(_onContinue);
  }

  /// TTS is playing
  void _onPlaying() {
    isPaused = false;
    isCanceled = false;
    onTtsStateChanged(TtsServiceState.playing);
  }

  /// TTS is paused
  void _onPaused() {
    isPaused = true;
    onTtsStateChanged(TtsServiceState.paused);
  }

  /// TTS is completed
  void _onComplete() {
    if (isCanceled) {
      isCanceled = false;
      return;
    }
    isPaused = false;
    _readerSendTtsNextUseCase();
  }

  /// TTS is cancelled
  void _onCancel() {
    isPaused = false;
    isCanceled = true;
    onTtsStateChanged(TtsServiceState.stopped);
  }

  /// TTS is continued
  void _onContinue() {
    isPaused = false;
    onTtsStateChanged(TtsServiceState.continued);
  }

  /// Pressing buttons

  /// Play or resume TTS
  void playButtonPressed() {
    if (isPaused) {
      _ttsService.resume();
    } else {
      _readerSendTtsPlayUseCase();
    }
  }

  /// Pause TTS
  void pauseButtonPressed() {
    _ttsService.pause();
  }

  /// Stop TTS
  void stopButtonPressed() {
    _ttsService.stop();
    _readerSendTtsStopUseCase();
  }

  /// Request to play TTS
  void _ttsPlay(String text) {
    _ttsService.speak(text);
  }

  /// Stop TTS
  void _ttsStop(void _) {
    _ttsService.stop();
  }

  /// Terminate TTS
  void _ttsEnd(void _) {
    _ttsService.stop();
    _onCancel();
  }

  Future<void> dispose() async {
    await _ttsEndStreamSubscription.cancel();
    await _ttsPlayStreamSubscription.cancel();
    await _ttsStopStreamSubscription.cancel();
    await _ttsService.stop();
  }
}
