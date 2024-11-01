part of 'bookmark_list.dart';

class BookmarkListOperationPanel extends StatelessWidget {
  const BookmarkListOperationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkListCubit, _State>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.isDragging != current.isDragging ||
          previous.selectedBookmarks != current.selectedBookmarks,
      builder: (context, state) {
        Widget child = const SizedBox.shrink();
        if (state.isSelecting && state.selectedBookmarks.isNotEmpty) {
          child = const _DeleteButton();
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
              )
                  .chain(CurveTween(curve: Curves.easeInOutCubicEmphasized))
                  .animate(animation),
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }
}
