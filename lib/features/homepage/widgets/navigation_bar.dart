part of '../homepage.dart';

class _NavigationBar extends StatelessWidget {
  const _NavigationBar();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final HomepageCubit cubit = BlocProvider.of<HomepageCubit>(context);
    final BookshelfCubit bookshelfCubit = BlocProvider.of<BookshelfCubit>(context);
    final BookmarkListCubit bookmarkListCubit = BlocProvider.of<BookmarkListCubit>(context);
    final CollectionListCubit collectionListCubit = BlocProvider.of<CollectionListCubit>(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<HomepageCubit, HomepageState>(
      buildWhen: (HomepageState previous, HomepageState current) =>
          previous.navItem != current.navItem || previous.isEnabled != current.isEnabled,
      builder: (BuildContext context, HomepageState state) {
        return NavigationBar(
          selectedIndex: HomepageNavigationItem.values.indexOf(state.navItem),
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: <Widget>[
            NavigationDestination(
              icon: Icon(
                Icons.shelves,
                color: colorScheme.onSurface.withValues(alpha: 0.64),
              ),
              selectedIcon: Icon(Icons.shelves, color: colorScheme.onSurface),
              label: appLocalizations.generalBookshelf,
              enabled: !state.navItem.isBookshelf && state.isEnabled,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.collections_bookmark_outlined,
                color: colorScheme.onSurface.withValues(alpha: 0.64),
              ),
              selectedIcon: Icon(Icons.collections_bookmark_rounded, color: colorScheme.onSurface),
              label: appLocalizations.generalCollection(2),
              enabled: !state.navItem.isCollection && state.isEnabled,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.bookmarks_outlined,
                color: colorScheme.onSurface.withValues(alpha: 0.64),
              ),
              selectedIcon: Icon(Icons.bookmarks_rounded, color: colorScheme.onSurface),
              label: appLocalizations.generalBookmark(2),
              enabled: !state.navItem.isBookmark && state.isEnabled,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
                color: colorScheme.onSurface.withValues(alpha: 0.64),
              ),
              selectedIcon: Icon(Icons.settings_rounded, color: colorScheme.onSurface),
              label: appLocalizations.generalSettings,
              enabled: !state.navItem.isSettings && state.isEnabled,
            ),
          ],
          onDestinationSelected: (int index) {
            switch (state.navItem) {
              case HomepageNavigationItem.bookshelf:
                bookshelfCubit.unfocused();
                break;
              case HomepageNavigationItem.bookmark:
                bookmarkListCubit.unfocused();
                break;
              case HomepageNavigationItem.collection:
                collectionListCubit.unfocused();
                break;
              default:
            }
            cubit.item = HomepageNavigationItem.fromIndex(index);
          },
        );
      },
    );
  }
}
