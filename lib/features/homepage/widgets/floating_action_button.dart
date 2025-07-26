part of '../homepage.dart';

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit bookshelfCubit =
        BlocProvider.of<BookshelfCubit>(context);
    final CollectionListCubit collectionListCubit =
        BlocProvider.of<CollectionListCubit>(context);

    return BlocBuilder<HomepageCubit, HomepageState>(
      buildWhen: (HomepageState previous, HomepageState current) =>
          previous.navItem != current.navItem,
      builder: (BuildContext context, HomepageState state) {
        Widget? child;

        switch (state.navItem) {
          case HomepageNavigationItem.bookshelf:
            child = FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (_) => BlocProvider<BookshelfCubit>.value(
                          value: bookshelfCubit,
                          child: const BookAddPage(),
                        )));
              },
              tooltip: appLocalizations.accessibilityAddBookButton,
              child: const Icon(Icons.add),
            );
            break;

          case HomepageNavigationItem.collection:
            child = FloatingActionButton(
              onPressed: () {
                showDialog<bool?>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) =>
                      const CollectionAddDialog(),
                ).then((bool? isSuccess) {
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
