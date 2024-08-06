import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../common_components/common_delete_drag_target.dart';
import '../bloc/bookshelf_bloc.dart';
import 'bookshelf_delete_button.dart';

class BookshelfOperationPanel extends StatelessWidget {
  const BookshelfOperationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.selectedBooks != current.selectedBooks ||
          previous.isDragging != current.isDragging,
      builder: (context, state) {
        Widget child = const SizedBox.shrink();
        if (state.isSelecting && state.selectedBooks.isNotEmpty) {
          child = const BookshelfDeleteButton();
        } else if (state.isDragging) {
          child = CommonDeleteDragTarget(
            onWillAcceptWithDetails: (details) => details.data is BookData,
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
