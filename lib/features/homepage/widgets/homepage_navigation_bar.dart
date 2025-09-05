import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/i18n/app_localizations.dart';
import '../../bookmark/presentation/bookmark_list/cubit/bookmark_list_cubit.dart';
import '../../books/presentation/book_list/cubit/bookshelf_cubit.dart';
import '../../collection/presentation/collection_list/cubit/collection_list_cubit.dart';
import '../../discover/presentation/browser/discover_browser_icon.dart';
import '../cubit/homepage_cubit.dart';

class HomepageNavigationBar extends StatelessWidget {
  const HomepageNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final HomepageCubit cubit = BlocProvider.of<HomepageCubit>(context);
    final BookListCubit bookshelfCubit =
        BlocProvider.of<BookListCubit>(context);
    final BookmarkListCubit bookmarkListCubit =
        BlocProvider.of<BookmarkListCubit>(context);
    final CollectionListCubit collectionListCubit =
        BlocProvider.of<CollectionListCubit>(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<HomepageCubit, HomepageState>(
      buildWhen: (HomepageState previous, HomepageState current) =>
          previous.navItem != current.navItem ||
          previous.isEnabled != current.isEnabled,
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
              icon: DiscoverBrowserIcon.outlined(
                color: colorScheme.onSurface.withValues(alpha: 0.64),
              ),
              selectedIcon: DiscoverBrowserIcon(
                color: colorScheme.onSurface,
              ),
              label: appLocalizations.generalCollection(2),
              enabled: !state.navItem.isDiscovery && state.isEnabled,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.bookmarks_outlined,
                color: colorScheme.onSurface.withValues(alpha: 0.64),
              ),
              selectedIcon:
                  Icon(Icons.bookmarks_rounded, color: colorScheme.onSurface),
              label: appLocalizations.generalBookmark(2),
              enabled: !state.navItem.isBookmark && state.isEnabled,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
                color: colorScheme.onSurface.withValues(alpha: 0.64),
              ),
              selectedIcon: Icon(
                Icons.settings_rounded,
                color: colorScheme.onSurface,
              ),
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
              case HomepageNavigationItem.discovery:
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
