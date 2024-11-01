part of '../bookmark_list.dart';

class _SelectButton extends StatelessWidget {
  const _SelectButton();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BookmarkListCubit>(context);
    return BlocBuilder<BookmarkListCubit, _State>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.bookmarkList != current.bookmarkList ||
          previous.selectedBookmarks != current.selectedBookmarks,
      builder: (context, state) {
        Widget? child;

        if (state.isSelecting) {
          child = CommonSelectModeTextButton(
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
