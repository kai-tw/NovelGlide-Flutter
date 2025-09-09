import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../generated/i18n/app_localizations.dart';
import '../../../../../../tts_service/domain/entities/tts_state_code.dart';
import '../../../cubit/reader_tts_cubit.dart';
import '../../../cubit/reader_tts_state.dart';

class ReaderTtsPlayPauseButton extends StatelessWidget {
  const ReaderTtsPlayPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderTtsCubit cubit = BlocProvider.of<ReaderTtsCubit>(context);

    return BlocBuilder<ReaderTtsCubit, ReaderTtsState>(
      buildWhen: (ReaderTtsState previous, ReaderTtsState current) =>
          previous.ttsState != current.ttsState,
      builder: (BuildContext context, ReaderTtsState state) {
        return IconButton(
          icon: Icon(switch (state.ttsState) {
            TtsStateCode.initial => Icons.play_arrow,
            TtsStateCode.ready => Icons.play_arrow,
            TtsStateCode.playing => Icons.pause,
            TtsStateCode.paused => Icons.play_arrow,
            TtsStateCode.continued => Icons.pause,
            TtsStateCode.completed => Icons.play_arrow,
            TtsStateCode.canceled => Icons.play_arrow,
          }),
          tooltip: switch (state.ttsState) {
            TtsStateCode.initial => appLocalizations.ttsPlay,
            TtsStateCode.ready => appLocalizations.ttsPlay,
            TtsStateCode.playing => appLocalizations.ttsPause,
            TtsStateCode.paused => appLocalizations.ttsPlay,
            TtsStateCode.continued => appLocalizations.ttsPause,
            TtsStateCode.completed => appLocalizations.ttsPlay,
            TtsStateCode.canceled => appLocalizations.ttsPlay,
          },
          onPressed: switch (state.ttsState) {
            TtsStateCode.initial => null,
            TtsStateCode.ready => cubit.sendPlaySignal,
            TtsStateCode.playing => cubit.pauseSpeaking,
            TtsStateCode.paused => cubit.resumeSpeaking,
            TtsStateCode.continued => cubit.pauseSpeaking,
            TtsStateCode.completed => cubit.sendPlaySignal,
            TtsStateCode.canceled => cubit.sendPlaySignal,
          },
        );
      },
    );
  }
}
