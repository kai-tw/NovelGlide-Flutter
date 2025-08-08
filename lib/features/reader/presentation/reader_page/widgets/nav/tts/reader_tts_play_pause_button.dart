part of '../../../reader.dart';

class ReaderTtsPlayPauseButton extends StatelessWidget {
  const ReaderTtsPlayPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.ttsState != current.ttsState,
      builder: (BuildContext context, ReaderState state) {
        final bool isPlaying =
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
