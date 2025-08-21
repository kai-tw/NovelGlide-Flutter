part of '../reader.dart';

class ReaderLoadingWidget extends StatelessWidget {
  const ReaderLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.code != current.code,
      builder: (BuildContext context, ReaderState state) {
        final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
        String? title;
        switch (state.code) {
          case ReaderLoadingStateCode.initial:
            title = appLocalizations.readerLoadingInitialize;
            break;

          case ReaderLoadingStateCode.bookLoading:
            title = appLocalizations.readerLoadingBookLoading;
            break;

          case ReaderLoadingStateCode.rendering:
            title = appLocalizations.readerLoadingRendering;
            break;

          case ReaderLoadingStateCode.loaded:
            break;
        }

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Center(
            child: CommonLoadingWidget(title: title),
          ),
        );
      },
    );
  }
}
