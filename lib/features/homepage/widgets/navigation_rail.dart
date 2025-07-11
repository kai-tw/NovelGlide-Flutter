part of '../homepage.dart';

class _NavigationRail extends StatelessWidget {
  const _NavigationRail();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final HomepageCubit cubit = BlocProvider.of<HomepageCubit>(context);
    final BookshelfCubit bookshelfCubit = BlocProvider.of<BookshelfCubit>(context);
    final BookmarkListCubit bookmarkListCubit = BlocProvider.of<BookmarkListCubit>(context);
    final CollectionListCubit collectionListCubit = BlocProvider.of<CollectionListCubit>(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: BlocBuilder<HomepageCubit, HomepageState>(
                buildWhen: (HomepageState previous, HomepageState current) =>
                    previous.navItem != current.navItem || previous.isEnabled != current.isEnabled,
                builder: (BuildContext context, HomepageState state) {
                  return NavigationRail(
                    selectedIndex: HomepageNavigationItem.values.indexOf(state.navItem),
                    indicatorColor: Colors.transparent,
                    backgroundColor: colorScheme.surfaceContainer,
                    labelType: NavigationRailLabelType.none,
                    destinations: <NavigationRailDestination>[
                      _buildDestination(
                        context,
                        iconData: Icons.shelves,
                        label: appLocalizations.generalBookshelf,
                        disabled: state.navItem.isBookshelf && state.isEnabled,
                      ),
                      _buildDestination(
                        context,
                        iconData: Icons.collections_bookmark_rounded,
                        label: appLocalizations.generalCollections,
                        disabled: state.navItem.isCollection && state.isEnabled,
                      ),
                      _buildDestination(
                        context,
                        iconData: Icons.bookmarks_rounded,
                        label: appLocalizations.generalBookmarks,
                        disabled: state.navItem.isBookmark && state.isEnabled,
                      ),
                      _buildDestination(
                        context,
                        iconData: Icons.settings,
                        label: appLocalizations.generalSettings,
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
                },
              ),
            ),
          ),
        );
      },
    );
  }

  NavigationRailDestination _buildDestination(
    BuildContext context, {
    required IconData iconData,
    required String label,
    required bool disabled,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return NavigationRailDestination(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      icon: Icon(iconData, color: colorScheme.onSurface.withValues(alpha: 0.64)),
      selectedIcon: Icon(iconData, color: colorScheme.onSurface),
      label: Text(label),
      disabled: disabled,
    );
  }
}
