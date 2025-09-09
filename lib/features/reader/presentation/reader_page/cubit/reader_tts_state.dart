import 'package:equatable/equatable.dart';

import '../../../../tts_service/domain/entities/tts_state_code.dart';

class ReaderTtsState extends Equatable {
  const ReaderTtsState({
    this.ttsState = TtsStateCode.initial,
  });

  final TtsStateCode ttsState;

  @override
  List<Object?> get props => <Object?>[ttsState];
}
