part of '../homepage.dart';

class _DeleteDragTarget<M extends Cubit<CommonListState<T>>, T>
    extends StatelessWidget {
  const _DeleteDragTarget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<M, CommonListState<T>>(
      buildWhen: (previous, current) =>
          previous.isDragging != current.isDragging,
      builder: (context, state) {
        Widget? child;

        if (state.isDragging) {
          child = CommonDeleteDragTarget(
            onWillAcceptWithDetails: (details) => details.data is T,
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 3.0),
                end: const Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            );
          },
          switchInCurve: Curves.easeInOutCubicEmphasized,
          switchOutCurve: Curves.easeInOutCubicEmphasized,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
