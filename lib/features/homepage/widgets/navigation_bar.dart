part of '../homepage.dart';

class _NavigationBar extends StatelessWidget {
  const _NavigationBar();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final HomepageCubit cubit = BlocProvider.of<HomepageCubit>(context);
    final BookshelfCubit bookshelfCubit =
        BlocProvider.of<BookshelfCubit>(context);
    final BookmarkListCubit bookmarkListCubit =
        BlocProvider.of<BookmarkListCubit>(context);
    final CollectionListCubit collectionListCubit =
        BlocProvider.of<CollectionListCubit>(context);

    return BlocBuilder<HomepageCubit, _HomepageState>(
      buildWhen: (_HomepageState previous, _HomepageState current) =>
          previous.navItem != current.navItem,
      builder: (BuildContext context, _HomepageState state) {
        return NavigationBar(
          selectedIndex: HomepageNavigationItem.values.indexOf(state.navItem),
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: <Widget>[
            _Destination(
              iconData: Icons.shelves,
              label: appLocalizations.bookshelfTitle,
              enabled: state.navItem != HomepageNavigationItem.bookshelf,
            ),
            _Destination(
              iconData: Icons.collections_bookmark_rounded,
              label: appLocalizations.collectionTitle,
              enabled: state.navItem != HomepageNavigationItem.collection,
            ),
            _Destination(
              iconData: Icons.bookmarks_rounded,
              label: appLocalizations.bookmarkListTitle,
              enabled: state.navItem != HomepageNavigationItem.bookmark,
            ),
            _Destination(
              iconData: Icons.settings_rounded,
              label: appLocalizations.settingsTitle,
              enabled: state.navItem != HomepageNavigationItem.settings,
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
            cubit.setItem(HomepageNavigationItem.values[
                index.clamp(0, HomepageNavigationItem.values.length - 1)]);
          },
        );
      },
    );
  }
}

class _Destination extends StatelessWidget {
  const _Destination({
    required this.iconData,
    required this.label,
    required this.enabled,
  });

  final IconData iconData;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return NavigationDestination(
      icon:
          Icon(iconData, color: colorScheme.onSurface.withValues(alpha: 0.64)),
      selectedIcon: Icon(iconData, color: colorScheme.onSurface),
      label: label,
      enabled: enabled,
    );
  }
}
