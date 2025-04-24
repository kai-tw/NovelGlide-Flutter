part of 'reader_default_navigation.dart';

class ReaderNavTtsButton extends StatelessWidget {
  const ReaderNavTtsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.code != current.code,
      builder: (BuildContext context, ReaderState state) {
        return IconButton(
          icon: const Icon(Icons.record_voice_over_rounded),
          tooltip: appLocalizations.readerTtsButton,
          onPressed: state.code.isLoaded
              ? () => cubit.setNavState(ReaderNavigationStateCode.ttsState)
              : null,
        );
      },
    );
  }
}
