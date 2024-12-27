part of '../reader.dart';

/// Settings button
class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final cubit = BlocProvider.of<ReaderCubit>(context);
        final isDisabled = state.code != LoadingStateCode.loaded;
        return IconButton(
          icon: Icon(
            Icons.settings_rounded,
            semanticLabel:
                AppLocalizations.of(context)!.accessibilityReaderSettingsButton,
          ),
          onPressed:
              isDisabled ? null : () => _navigateToSettingsPage(context, cubit),
        );
      },
    );
  }

  void _navigateToSettingsPage(BuildContext context, ReaderCubit cubit) {
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 1.0,
      showDragHandle: true,
      barrierColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: cubit,
          child: const ReaderBottomSheet(),
        );
      },
    );
  }
}
