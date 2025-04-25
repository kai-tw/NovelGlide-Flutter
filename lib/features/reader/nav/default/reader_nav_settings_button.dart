part of '../../reader.dart';

class ReaderNavSettingsButton extends StatelessWidget {
  const ReaderNavSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.code != current.code ||
          previous.ttsState != current.ttsState,
      builder: (BuildContext context, ReaderState state) {
        final bool isEnabled = state.code.isLoaded || state.ttsState.isStopped;
        return IconButton(
          icon: const Icon(Icons.settings_rounded),
          tooltip: appLocalizations.readerSettings,
          onPressed:
              isEnabled ? () => _navigateToSettingsPage(context, cubit) : null,
        );
      },
    );
  }

  void _navigateToSettingsPage(BuildContext context, ReaderCubit cubit) {
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 1.0,
      showDragHandle: true,
      barrierColor:
          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
      builder: (BuildContext context) {
        return BlocProvider<ReaderCubit>.value(
          value: cubit,
          child: const ReaderBottomSheet(),
        );
      },
    );
  }
}
