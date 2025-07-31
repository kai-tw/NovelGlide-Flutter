part of '../../tts_service.dart';

class TtsSettingsState extends Equatable {
  const TtsSettingsState({
    this.ttsState = TtsServiceState.initial,
    this.voiceList = const <TtsVoiceData>[],
    this.data = const TtsPreferenceData(),
    this.isTextEmpty = false,
  });

  final TtsServiceState ttsState;
  final List<TtsVoiceData> voiceList;
  final TtsPreferenceData data;
  final bool isTextEmpty;

  @override
  List<Object?> get props => <Object?>[
        ttsState,
        voiceList,
        data,
        isTextEmpty,
      ];

  TtsSettingsState copyWith({
    TtsServiceState? ttsState,
    List<TtsVoiceData>? voiceList,
    TtsPreferenceData? data,
    bool? isVoiceNull,
    bool? isTextEmpty,
  }) {
    return TtsSettingsState(
      ttsState: ttsState ?? this.ttsState,
      voiceList: voiceList ?? this.voiceList,
      data: data ?? this.data,
      isTextEmpty: isTextEmpty ?? this.isTextEmpty,
    );
  }
}
