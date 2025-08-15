import 'package:equatable/equatable.dart';

import '../../../tts_service/domain/entities/tts_voice_data.dart';

class TtsPreferenceData extends Equatable {
  const TtsPreferenceData({
    this.pitch = defaultPitch,
    this.volume = defaultVolume,
    this.speechRate = defaultSpeedRate,
    this.voiceData,
  });

  static const double defaultPitch = 1.0;
  static const double defaultVolume = 1.0;
  static const double defaultSpeedRate = 0.5;

  final double pitch;
  final double volume;
  final double speechRate;
  final TtsVoiceData? voiceData;

  @override
  List<Object?> get props => <Object?>[
        pitch,
        volume,
        speechRate,
        voiceData,
      ];

  TtsPreferenceData copyWith({
    double? pitch,
    double? volume,
    double? speechRate,
    TtsVoiceData? voiceData,
  }) {
    return TtsPreferenceData(
      pitch: pitch ?? this.pitch,
      volume: volume ?? this.volume,
      speechRate: speechRate ?? this.speechRate,
      voiceData: voiceData ?? this.voiceData,
    );
  }

  TtsPreferenceData copyWithVoiceData(TtsVoiceData? voiceData) {
    return TtsPreferenceData(
      pitch: pitch,
      volume: volume,
      speechRate: speechRate,
      voiceData: voiceData,
    );
  }
}
