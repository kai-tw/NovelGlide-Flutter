part of 'reader_default_navigation.dart';

class ReaderNavSettingsButton extends StatelessWidget {
  const ReaderNavSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.ttsState != current.ttsState,
      builder: (context, state) {
        final isEnabled = state.code.isLoaded || state.ttsState.isStopped;
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
        return BlocProvider.value(
          value: cubit,
          child: const ReaderBottomSheet(),
        );
      },
    );
  }
}
