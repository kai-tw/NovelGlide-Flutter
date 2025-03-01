part of 'reader_default_navigation.dart';

class ReaderNavNextButton extends StatelessWidget {
  const ReaderNavNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.ttsState != current.ttsState,
      builder: (context, state) {
        final isEnabled = state.code.isLoaded && state.ttsState.isStopped;
        return IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          tooltip: appLocalizations.readerNextChapter,
          onPressed: isEnabled ? cubit.nextPage : null,
        );
      },
    );
  }
}
