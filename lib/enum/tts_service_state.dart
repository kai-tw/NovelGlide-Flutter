enum TtsServiceState {
  initial,
  playing,
  paused,
  stopped,
  continued;

  bool get isPlaying => this == TtsServiceState.playing;
  bool get isPaused => this == TtsServiceState.paused;
  bool get isStopped => this == TtsServiceState.stopped;
  bool get isContinued => this == TtsServiceState.continued;
}
