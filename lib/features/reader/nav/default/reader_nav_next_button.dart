part of 'reader_default_navigation.dart';

class ReaderNavNextButton extends StatelessWidget {
  const ReaderNavNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          tooltip: appLocalizations.readerNextChapter,
          onPressed: state.code.isLoaded
              ? () => cubit.state.isRtl
                  ? cubit.webViewHandler.prevPage()
                  : cubit.webViewHandler.nextPage()
              : null,
        );
      },
    );
  }
}
