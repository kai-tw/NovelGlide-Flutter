import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../generated/i18n/app_localizations.dart';
import '../../../../../../tts_service/domain/entities/tts_state_code.dart';
import '../../../cubit/reader_tts_cubit.dart';
import '../../../cubit/reader_tts_state.dart';

class ReaderTtsStopButton extends StatelessWidget {
  const ReaderTtsStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderTtsCubit cubit = BlocProvider.of<ReaderTtsCubit>(context);

    return BlocBuilder<ReaderTtsCubit, ReaderTtsState>(
      buildWhen: (ReaderTtsState previous, ReaderTtsState current) =>
          previous.ttsState != current.ttsState,
      builder: (BuildContext context, ReaderTtsState state) {
        return IconButton(
          icon: const Icon(Icons.stop_rounded),
          tooltip: appLocalizations.ttsStop,
          onPressed: switch (state.ttsState) {
            TtsStateCode.initial => null,
            TtsStateCode.ready => null,
            TtsStateCode.playing => cubit.stopSpeaking,
            TtsStateCode.paused => cubit.stopSpeaking,
            TtsStateCode.continued => cubit.stopSpeaking,
            TtsStateCode.completed => null,
            TtsStateCode.canceled => null,
          },
        );
      },
    );
  }
}
