part of '../reader.dart';

class _OverlapWidget extends StatelessWidget {
  const _OverlapWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.code != current.code,
      builder: (BuildContext context, ReaderState state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(
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
          child: state.code.isLoaded
              ? const SizedBox.shrink()
              : const _LoadingWidget(),
        );
      },
    );
  }
}
