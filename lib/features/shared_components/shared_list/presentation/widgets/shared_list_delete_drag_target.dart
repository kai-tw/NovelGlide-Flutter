import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_delete_drag_target.dart';
import '../../shared_list.dart';

class SharedListDeleteDragTarget<M extends Cubit<SharedListState<T>>,
    T extends Object> extends StatelessWidget {
  const SharedListDeleteDragTarget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<M, SharedListState<T>>(
      buildWhen: (SharedListState<T> previous, SharedListState<T> current) =>
          previous.isDragging != current.isDragging,
      builder: (BuildContext context, SharedListState<T> state) {
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
