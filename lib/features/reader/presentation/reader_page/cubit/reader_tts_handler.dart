part of 'reader_cubit.dart';

class ReaderTTSHandler {
  factory ReaderTTSHandler({
    required ReaderWebViewHandler webViewHandler,
    required void Function(TtsServiceState state) onTtsStateChanged,
  }) {
    final ReaderTTSHandler handler = ReaderTTSHandler._(
      webViewHandler: webViewHandler,
      onTtsStateChanged: onTtsStateChanged,
    );
    handler._ttsService = TtsService(onReady: handler._onReady);
    handler._messageStreamSubscription =
        webViewHandler.messages.listen(handler._messageDispatcher);
    return handler;
  }

  ReaderTTSHandler._({
    required this.webViewHandler,
    required this.onTtsStateChanged,
  });

  late TtsService _ttsService;
  final ReaderWebViewHandler webViewHandler;
  late final StreamSubscription<ReaderWebMessageDto> _messageStreamSubscription;
  final void Function(TtsServiceState state) onTtsStateChanged;

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
  void _messageDispatcher(ReaderWebMessageDto message) {
    switch (message.route) {
      case 'ttsPlay':
        assert(message.data is String);
        _ttsPlay(message.data as String);
        break;

      case 'ttsStop':
        _ttsStop();
        break;

      case 'ttsEnd':
        _ttsEnd();
        break;
    }
  }

  /// Request to play TTS
  void _ttsPlay(dynamic data) {
    _ttsService.speak(data as String);
  }

  /// Stop TTS
  void _ttsStop() {
    _ttsService.stop();
  }

  /// Terminate TTS
  void _ttsEnd() {
    _ttsService.stop();
    _onCancel();
  }

  Future<void> dispose() async {
    await _messageStreamSubscription.cancel();
    await _ttsService.stop();
  }
}
