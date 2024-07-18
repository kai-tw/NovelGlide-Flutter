import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bookmark_manager_bloc.dart';
import 'bookmark_manager_delete_button.dart';

class BookmarkManagerFloatingActionButton extends StatelessWidget {
  const BookmarkManagerFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkManagerCubit, BookmarkManagerState>(
      buildWhen: (previous, current) => previous.selectedBookmarks != current.selectedBookmarks,
      builder: (BuildContext context, BookmarkManagerState state) {
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
          child: state.selectedBookmarks.isEmpty ? null : const BookmarkManagerDeleteButton(),
        );
      },
    );
  }
}
