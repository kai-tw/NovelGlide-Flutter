import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/i18n/app_localizations.dart';
import '../../bookmark/presentation/bookmark_list/cubit/bookmark_list_cubit.dart';
import '../../books/presentation/book_list/cubit/bookshelf_cubit.dart';
import '../../collection/presentation/collection_list/cubit/collection_list_cubit.dart';
import '../../discover/presentation/browser/discover_browser_icon.dart';
import '../cubit/homepage_cubit.dart';

class HomepageNavigationRail extends StatelessWidget {
  const HomepageNavigationRail({super.key});

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
          icon: DiscoverBrowserIcon.outlined(
            color: colorScheme.onSurface.withValues(alpha: 0.64),
          ),
          selectedIcon: DiscoverBrowserIcon(
            color: colorScheme.onSurface,
          ),
          label: Text(appLocalizations.generalDiscover),
          disabled: state.navItem.isDiscovery && state.isEnabled,
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          icon: Icon(
            Icons.bookmarks_outlined,
            color: colorScheme.onSurface.withValues(alpha: 0.64),
          ),
          selectedIcon: Icon(
            Icons.bookmarks_rounded,
            color: colorScheme.onSurface,
          ),
          label: Text(appLocalizations.generalBookmark(2)),
          disabled: state.navItem.isBookmark && state.isEnabled,
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          icon: Icon(
            Icons.settings_outlined,
            color: colorScheme.onSurface.withValues(alpha: 0.64),
          ),
          selectedIcon: Icon(
            Icons.settings_rounded,
            color: colorScheme.onSurface,
          ),
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
          case HomepageNavigationItem.discovery:
            collectionListCubit.unfocused();
            break;
          default:
        }
        cubit.item = HomepageNavigationItem.fromIndex(index);
      },
    );
  }
}
