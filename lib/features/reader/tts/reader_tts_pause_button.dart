import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/i18n/app_localizations.dart';
import '../cubit/reader_cubit.dart';

class ReaderTtsPauseButton extends StatelessWidget {
  const ReaderTtsPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.ttsState != current.ttsState,
      builder: (context, state) {
        final isEnabled =
            state.ttsState.isPlaying || state.ttsState.isContinued;
        return IconButton(
          icon: const Icon(Icons.pause_rounded),
          tooltip: appLocalizations.ttsPause,
          onPressed: isEnabled ? cubit.ttsHandler.pauseButtonPressed : null,
        );
      },
    );
  }
}
