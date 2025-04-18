part of '../homepage.dart';

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bookshelfCubit = BlocProvider.of<BookshelfCubit>(context);
    final collectionListCubit = BlocProvider.of<CollectionListCubit>(context);

    return BlocBuilder<HomepageCubit, _HomepageState>(
      buildWhen: (previous, current) => previous.navItem != current.navItem,
      builder: (context, state) {
        Widget? child;

        switch (state.navItem) {
          case HomepageNavigationItem.bookshelf:
            child = FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const BookAddDialog(),
                ).then((isSuccess) {
                  if (isSuccess == true) {
                    bookshelfCubit.refresh();
                  }
                });
              },
              tooltip: appLocalizations.accessibilityAddBookButton,
              child: const Icon(Icons.add),
            );
            break;

          case HomepageNavigationItem.collection:
            child = FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const CollectionAddDialog(),
                ).then((isSuccess) {
                  if (isSuccess == true) {
                    collectionListCubit.refresh();
                  }
                });
              },
              tooltip: appLocalizations.collectionAddBtn,
              child: const Icon(Icons.add),
            );
            break;

          default:
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(2.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            );
          },
          switchInCurve: Curves.easeInOutCubicEmphasized,
          switchOutCurve: Curves.easeInOutCubicEmphasized,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
