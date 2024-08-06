import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../common_components/common_delete_drag_target.dart';
import '../bloc/bookmark_list_bloc.dart';
import 'bookmark_list_delete_button.dart';

class BookmarkListOperationPanel extends StatelessWidget {
  const BookmarkListOperationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkListCubit, BookmarkListState>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.isDragging != current.isDragging ||
          previous.selectedBookmarks != current.selectedBookmarks,
      builder: (context, state) {
        Widget child = const SizedBox.shrink();
        if (state.isSelecting && state.selectedBookmarks.isNotEmpty) {
          child = const BookmarkListDeleteButton();
        } else if (state.isDragging) {
          child = CommonDeleteDragTarget(
            onWillAcceptWithDetails: (details) => details.data is BookmarkData,
          );
        }
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
          child: child,
        );
      },
    );
  }
}
