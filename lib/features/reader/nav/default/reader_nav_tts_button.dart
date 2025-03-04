part of 'reader_default_navigation.dart';

class ReaderNavTtsButton extends StatelessWidget {
  const ReaderNavTtsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
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
