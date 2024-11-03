part of 'bookshelf.dart';

class BookshelfOperationPanel extends StatelessWidget {
  const BookshelfOperationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, CommonListState>(
      buildWhen: (previous, current) =>
          previous.isDragging != current.isDragging,
      builder: (context, state) {
        Widget? child;

        if (state.isDragging) {
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
