part of '../homepage.dart';

class _NavigationRail extends StatelessWidget {
  const _NavigationRail();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: BlocBuilder<HomepageCubit, HomepageState>(
                buildWhen: (HomepageState previous, HomepageState current) =>
                    previous.navItem != current.navItem ||
                    previous.isEnabled != current.isEnabled,
                builder: _railBuilder,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _railBuilder(BuildContext context, HomepageState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final HomepageCubit cubit = BlocProvider.of<HomepageCubit>(context);
    final BookListCubit bookshelfCubit =
        BlocProvider.of<BookListCubit>(context);
    final BookmarkListCubit bookmarkListCubit =
        BlocProvider.of<BookmarkListCubit>(context);
    final CollectionListCubit collectionListCubit =
        BlocProvider.of<CollectionListCubit>(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return NavigationRail(
      selectedIndex: HomepageNavigationItem.values.indexOf(state.navItem),
      indicatorColor: Colors.transparent,
      backgroundColor: colorScheme.surfaceContainer,
      labelType: NavigationRailLabelType.none,
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          icon: Icon(
            Icons.shelves,
            color: colorScheme.onSurface.withValues(alpha: 0.64),
          ),
          selectedIcon: Icon(Icons.shelves, color: colorScheme.onSurface),
          label: Text(appLocalizations.generalBookshelf),
          disabled: state.navItem.isBookshelf && state.isEnabled,
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          icon: Icon(
            Icons.collections_bookmark_outlined,
            color: colorScheme.onSurface.withValues(alpha: 0.64),
          ),
          selectedIcon: Icon(Icons.collections_bookmark_rounded,
              color: colorScheme.onSurface),
          label: Text(appLocalizations.generalCollection(2)),
          disabled: state.navItem.isCollection && state.isEnabled,
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          icon: Icon(
            Icons.bookmarks_outlined,
            color: colorScheme.onSurface.withValues(alpha: 0.64),
          ),
          selectedIcon:
              Icon(Icons.bookmarks_rounded, color: colorScheme.onSurface),
          label: Text(appLocalizations.generalBookmark(2)),
          disabled: state.navItem.isBookmark && state.isEnabled,
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          icon: Icon(
            Icons.settings_outlined,
            color: colorScheme.onSurface.withValues(alpha: 0.64),
          ),
          selectedIcon:
              Icon(Icons.settings_rounded, color: colorScheme.onSurface),
          label: Text(appLocalizations.generalSettings),
          disabled: state.navItem.isSettings && state.isEnabled,
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
  }
}
