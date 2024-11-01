part of '../bookshelf.dart';

class _SelectButton extends StatelessWidget {
  const _SelectButton();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<BookshelfCubit, _BookshelfState>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.bookList != current.bookList ||
          previous.selectedBooks != current.selectedBooks,
      builder: (context, state) {
        Widget? child;

        if (state.isSelecting) {
          child = CommonSelectModeTextButton(
            isEmpty: state.bookList.isEmpty,
            isSelectAll: state.selectedBooks.length == state.bookList.length,
            selectAll: cubit.selectAllBooks,
            deselectAll: cubit.deselectAllBooks,
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
