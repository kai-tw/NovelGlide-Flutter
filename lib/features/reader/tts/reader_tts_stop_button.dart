import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/i18n/app_localizations.dart';
import '../cubit/reader_cubit.dart';

class ReaderTtsStopButton extends StatelessWidget {
  const ReaderTtsStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.ttsState != current.ttsState,
      builder: (BuildContext context, ReaderState state) {
        final bool isEnabled = state.ttsState.isPlaying ||
            state.ttsState.isPaused ||
            state.ttsState.isContinued;
        return IconButton(
          icon: const Icon(Icons.stop_rounded),
          tooltip: appLocalizations.ttsStop,
          onPressed: isEnabled ? cubit.ttsHandler.stopButtonPressed : null,
        );
      },
    );
  }
}
