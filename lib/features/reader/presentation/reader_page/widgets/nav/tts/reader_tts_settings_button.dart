part of '../../../reader.dart';

class ReaderTtsSettingsButton extends StatelessWidget {
  const ReaderTtsSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.ttsState != current.ttsState,
      builder: (BuildContext context, ReaderState state) {
        final bool isEnabled = state.ttsState.isReady;
        return IconButton(
          icon: const Icon(Icons.settings_rounded),
          tooltip: appLocalizations.ttsSettingsTitle,
          onPressed: isEnabled ? () => _navigateToTtsSettings(context) : null,
        );
      },
    );
  }

  void _navigateToTtsSettings(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const TtsSettingsPage()))
        .then((_) => cubit.ttsHandler.reload());
  }
}
