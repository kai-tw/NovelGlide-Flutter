part of 'reader_default_navigation.dart';

class ReaderNavPreviousButton extends StatelessWidget {
  const ReaderNavPreviousButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.code != current.code ||
          previous.ttsState != current.ttsState,
      builder: (BuildContext context, ReaderState state) {
        final bool isEnabled = state.code.isLoaded && state.ttsState.isStopped;
        return IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          tooltip: appLocalizations.readerPreviousPage,
          onPressed: isEnabled ? cubit.previousPage : null,
        );
      },
    );
  }
}
