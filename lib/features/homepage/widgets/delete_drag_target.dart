part of '../homepage.dart';

class _DeleteDragTarget<M extends Cubit<CommonListState<T>>, T extends Object>
    extends StatelessWidget {
  const _DeleteDragTarget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<M, CommonListState<T>>(
      buildWhen: (CommonListState<T> previous, CommonListState<T> current) =>
          previous.isDragging != current.isDragging,
      builder: (BuildContext context, CommonListState<T> state) {
        Widget? child;

        if (state.isDragging) {
          child = CommonDeleteDragTarget<T>(
            onWillAcceptWithDetails: (DragTargetDetails<Object> details) =>
                details.data is T,
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
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
