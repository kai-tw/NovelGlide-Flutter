import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/i18n/app_localizations.dart';
import '../cubit/reader_cubit.dart';

class ReaderTtsPlayPauseButton extends StatelessWidget {
  const ReaderTtsPlayPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.ttsState != current.ttsState,
      builder: (context, state) {
        final isPlaying =
            state.ttsState.isPlaying || state.ttsState.isContinued;
        return IconButton(
          icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow),
          tooltip:
              isPlaying ? appLocalizations.ttsPause : appLocalizations.ttsPlay,
          onPressed: state.ttsState.isReady
              ? isPlaying
                  ? cubit.ttsHandler.pauseButtonPressed
                  : cubit.ttsHandler.playButtonPressed
              : null,
        );
      },
    );
  }
}
