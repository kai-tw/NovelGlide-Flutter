import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/book_data.dart';
import '../../data/bookmark_data.dart';
import '../../data/window_class.dart';
import '../common_components/common_delete_drag_target.dart';
import 'bloc/homepage_bloc.dart';
import 'widgets/homepage_floating_action_button.dart';

class HomepageTabSection extends StatelessWidget {
  const HomepageTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    double maxWidth = MediaQuery.of(context).size.width - kFloatingActionButtonMargin;

    if (windowClass != WindowClass.compact) {
      maxWidth *= 0.618;
    }

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: BlocBuilder<HomepageCubit, HomepageState>(
                buildWhen: (previous, current) => previous.isDragging != current.isDragging,
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 3.0),
                          end: const Offset(0.0, 0.0),
                        ).chain(CurveTween(curve: Curves.easeInOutCubicEmphasized)).animate(animation),
                        child: child,
                      );
                    },
                    child: state.isDragging
                        ? CommonDeleteDragTarget(
                            onWillAcceptWithDetails: (details) =>
                                details.data is BookData || details.data is BookmarkData,
                          )
                        : const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ),
          const HomepageFloatingActionButton(),
        ],
      ),
    );
  }
}
