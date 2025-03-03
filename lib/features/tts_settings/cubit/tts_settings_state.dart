part of 'tts_settings_cubit.dart';

class TtsSettingsState extends Equatable {
  const TtsSettingsState({
    this.ttsState = TtsServiceState.initial,
    this.voiceList = const [],
    this.pitch = TtsService.defaultPitch,
    this.volume = TtsService.defaultVolume,
    this.speechRate = TtsService.defaultSpeedRate,
    this.voiceData,
    this.isTextEmpty = false,
  });

  final TtsServiceState ttsState;
  final List<TtsVoiceData> voiceList;
  final double pitch;
  final double volume;
  final double speechRate;
  final TtsVoiceData? voiceData;
  final bool isTextEmpty;

  @override
  List<Object?> get props => [
        ttsState,
        voiceList,
        pitch,
        volume,
        speechRate,
        voiceData,
        isTextEmpty,
      ];

  TtsSettingsState copyWith({
    TtsServiceState? ttsState,
    List<TtsVoiceData>? voiceList,
    double? pitch,
    double? volume,
    double? speechRate,
    TtsVoiceData? voiceData,
    bool? isVoiceNull,
    bool? isTextEmpty,
  }) {
    return TtsSettingsState(
      ttsState: ttsState ?? this.ttsState,
      voiceList: voiceList ?? this.voiceList,
      pitch: pitch ?? this.pitch,
      volume: volume ?? this.volume,
      speechRate: speechRate ?? this.speechRate,
      voiceData: isVoiceNull == true ? null : (voiceData ?? this.voiceData),
      isTextEmpty: isTextEmpty ?? this.isTextEmpty,
    );
  }
}
