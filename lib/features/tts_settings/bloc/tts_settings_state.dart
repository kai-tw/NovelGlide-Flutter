import 'package:equatable/equatable.dart';

import '../../../data_model/tts_data.dart';
import '../../../enum/tts_service_state.dart';
import '../../../services/tts_service.dart';

class TtsSettingsState extends Equatable {
  const TtsSettingsState({
    this.ttsState = TtsServiceState.initial,
    this.dataList = const [],
    this.pitch = TtsService.defaultPitch,
    this.volume = TtsService.defaultVolume,
    this.speechRate = TtsService.defaultSpeedRate,
  });

  final TtsServiceState ttsState;
  final List<TtsData> dataList;
  final double pitch;
  final double volume;
  final double speechRate;

  @override
  List<Object?> get props => [
        ttsState,
        dataList,
        pitch,
        volume,
        speechRate,
      ];

  TtsSettingsState copyWith({
    TtsServiceState? ttsState,
    List<TtsData>? dataList,
    double? pitch,
    double? volume,
    double? speechRate,
  }) {
    return TtsSettingsState(
      ttsState: ttsState ?? this.ttsState,
      dataList: dataList ?? this.dataList,
      pitch: pitch ?? this.pitch,
      volume: volume ?? this.volume,
      speechRate: speechRate ?? this.speechRate,
    );
  }
}
