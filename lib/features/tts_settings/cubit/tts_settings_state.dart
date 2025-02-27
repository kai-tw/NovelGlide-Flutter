part of 'tts_settings_cubit.dart';

class TtsSettingsState extends Equatable {
  const TtsSettingsState({
    this.ttsState = TtsServiceState.initial,
    this.languageList = const [],
    this.pitch = TtsService.defaultPitch,
    this.volume = TtsService.defaultVolume,
    this.speechRate = TtsService.defaultSpeedRate,
  });

  final TtsServiceState ttsState;
  final List<String> languageList;
  final double pitch;
  final double volume;
  final double speechRate;

  @override
  List<Object?> get props => [
        ttsState,
        languageList,
        pitch,
        volume,
        speechRate,
      ];

  TtsSettingsState copyWith({
    TtsServiceState? ttsState,
    List<String>? languageList,
    double? pitch,
    double? volume,
    double? speechRate,
  }) {
    return TtsSettingsState(
      ttsState: ttsState ?? this.ttsState,
      languageList: languageList ?? this.languageList,
      pitch: pitch ?? this.pitch,
      volume: volume ?? this.volume,
      speechRate: speechRate ?? this.speechRate,
    );
  }
}
