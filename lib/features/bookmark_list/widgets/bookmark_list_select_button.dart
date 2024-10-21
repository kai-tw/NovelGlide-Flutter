import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_components/common_list_select_text_button.dart';
import '../bloc/bookmark_list_bloc.dart';

class BookmarkListSelectButton extends StatelessWidget {
  const BookmarkListSelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    return BlocBuilder<BookmarkListCubit, BookmarkListState>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.selectedBookmarks != current.selectedBookmarks,
      builder: (context, state) {
        Widget? child;

        if (state.isSelecting) {
          child = CommonListSelectTextButton(
            isEmpty: state.bookmarkList.isEmpty,
            isSelectAll:
                state.selectedBookmarks.length == state.bookmarkList.length,
            selectAll: cubit.selectAllBookmarks,
            deselectAll: cubit.deselectAllBookmarks,
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: child,
        );
      },
    );
  }
}
