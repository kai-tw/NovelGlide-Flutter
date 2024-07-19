import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/chapter_data.dart';
import '../../../data/window_class.dart';
import '../../common_components/common_delete_drag_target.dart';
import '../bloc/toc_bloc.dart';
import 'toc_continue_reading_button.dart';

class TocDraggingTargetBar extends StatelessWidget {
  const TocDraggingTargetBar({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    BoxConstraints constraints;

    switch (windowClass) {
      case WindowClass.compact:
        constraints = BoxConstraints(maxWidth: WindowClass.compact.maxWidth);
        break;
      default:
        constraints = const BoxConstraints(maxWidth: 360.0);
    }

    return BlocBuilder<TocCubit, TocState>(
      buildWhen: (previous, current) => previous.isDragging != current.isDragging,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: const Offset(0.0, 0.0),
              ).chain(CurveTween(curve: Curves.easeInOutCubicEmphasized)).animate(animation),
              child: child,
            );
          },
          child: state.isDragging
              ? Container(
                  height: 56.0,
                  constraints: constraints,
                  margin: const EdgeInsets.all(16.0),
                  child: CommonDeleteDragTarget(
                    onWillAcceptWithDetails: (details) => details.data is ChapterData,
                  ),
                )
              : const TocContinueReadingButton(),
        );
      },
    );
  }
}
