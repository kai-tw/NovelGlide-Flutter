part of 'reader_default_navigation.dart';

class ReaderNavPreviousButton extends StatelessWidget {
  const ReaderNavPreviousButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          tooltip: appLocalizations.readerPreviousChapter,
          onPressed: state.code.isLoaded
              ? () => cubit.state.isRtl
                  ? cubit.webViewHandler.nextPage()
                  : cubit.webViewHandler.prevPage()
              : null,
        );
      },
    );
  }
}
