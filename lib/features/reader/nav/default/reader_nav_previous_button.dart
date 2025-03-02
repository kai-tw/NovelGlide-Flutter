part of 'reader_default_navigation.dart';

class ReaderNavPreviousButton extends StatelessWidget {
  const ReaderNavPreviousButton({super.key});

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
          icon: const Icon(Icons.arrow_back_ios_rounded),
          tooltip: appLocalizations.readerPreviousChapter,
          onPressed: isEnabled ? cubit.previousPage : null,
        );
      },
    );
  }
}
