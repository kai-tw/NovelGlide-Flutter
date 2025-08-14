enum TtsStateCode {
  initial,
  ready,
  playing,
  paused,
  continued,
  completed,
  canceled;

  bool get isPlaying => this == TtsStateCode.playing;

  bool get isPaused => this == TtsStateCode.paused;

  bool get isReady => this == TtsStateCode.ready;

  bool get isContinued => this == TtsStateCode.continued;
}
