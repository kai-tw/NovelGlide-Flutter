part of '../reader.dart';

class _OverlapWidget extends StatelessWidget {
  const _OverlapWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ReaderCubit, _ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        Widget child;

        switch (state.code) {
          case LoadingStateCode.loaded:
            child = const _GestureDetector();
            break;

          default:
            child = const _LoadingWidget();
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: const Offset(0, 0),
              ).animate(animation),
              child: child,
            ),
          ),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: child,
        );
      },
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ReaderCubit, _ReaderState>(
      buildWhen: (previous, current) =>
          previous.loadingStateCode != current.loadingStateCode,
      builder: (context, state) {
        final appLocalizations = AppLocalizations.of(context)!;
        String? title;
        switch (state.loadingStateCode) {
          case ReaderLoadingStateCode.initial:
            title = appLocalizations.readerLoadingInitialize;
            break;

          case ReaderLoadingStateCode.bookLoading:
            title = appLocalizations.readerLoadingBookLoading;
            break;

          case ReaderLoadingStateCode.rendering:
            title = appLocalizations.readerLoadingRendering;
            break;
        }

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Center(
            child: CommonLoading(title: title),
          ),
        );
      },
    );
  }
}
