import 'package:equatable/equatable.dart';

import '../../../domain/entities/tts_preference_data.dart';
import '../../../domain/entities/tts_state_code.dart';
import '../../../domain/entities/tts_voice_data.dart';

class TtsSettingsState extends Equatable {
  const TtsSettingsState({
    this.ttsState = TtsStateCode.initial,
    this.voiceList = const <TtsVoiceData>[],
    this.data = const TtsPreferenceData(),
    this.isTextEmpty = false,
  });

  final TtsStateCode ttsState;
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
    TtsStateCode? ttsState,
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
