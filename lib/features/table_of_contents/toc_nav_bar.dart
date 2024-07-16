import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/window_class.dart';
import 'bloc/toc_bloc.dart';
import 'widgets/toc_dragging_target_bar.dart';

class TocNavBar extends StatelessWidget {
  const TocNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);

    switch (windowClass) {
      case WindowClass.compact:
        return BlocBuilder<TocCubit, TocState>(
          buildWhen: (previous, current) => previous.isDragging != current.isDragging,
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 2.0),
                    end: const Offset(0.0, 0.0),
                  ).chain(CurveTween(curve: Curves.easeInOutCubicEmphasized)).animate(animation),
                  child: child,
                );
              },
              child: state.isDragging ? const TocDraggingTargetBar() : const SizedBox.shrink(),
            );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}