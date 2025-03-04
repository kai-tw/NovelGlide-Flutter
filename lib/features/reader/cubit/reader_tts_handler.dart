part of 'reader_cubit.dart';

class ReaderTTSHandler {
  late TtsService _ttsService;
  final ReaderWebViewHandler webViewHandler;
  final void Function(TtsServiceState state) onTtsStateChanged;
  bool isPaused = false;
  bool isCanceled = false;

  factory ReaderTTSHandler({
    required ReaderWebViewHandler webViewHandler,
    required void Function(TtsServiceState state) onTtsStateChanged,
  }) {
    return ReaderTTSHandler._(
      webViewHandler: webViewHandler,
      onTtsStateChanged: onTtsStateChanged,
    ).._init();
  }

  ReaderTTSHandler._({
    required this.webViewHandler,
    required this.onTtsStateChanged,
  });

  void _init() {
    _ttsService = TtsService(onReady: _onReady);
  }

  void reload() {
    _init();
  }

  /// Events

  /// TTS service is ready
  void _onReady() {
    webViewHandler.register('ttsPlay', _ttsPlay);
    webViewHandler.register('ttsStop', _ttsStop);
    webViewHandler.register('ttsEnd', _ttsEnd);
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
    webViewHandler.send('ttsNext');
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
      webViewHandler.send('ttsPlay');
    }
  }

  /// Pause TTS
  void pauseButtonPressed() {
    _ttsService.pause();
  }

  /// Stop TTS
  void stopButtonPressed() {
    _ttsService.stop();
    webViewHandler.send('ttsStop');
  }

  /// Messages

  /// Request to play TTS
  void _ttsPlay(dynamic data) {
    _ttsService.speak(data as String);
  }

  /// Stop TTS
  void _ttsStop(_) {
    _ttsService.stop();
  }

  /// Terminate TTS
  void _ttsEnd(_) {
    _ttsService.stop();
    _onCancel();
  }

  void dispose() {
    _ttsService.stop();
  }
}
