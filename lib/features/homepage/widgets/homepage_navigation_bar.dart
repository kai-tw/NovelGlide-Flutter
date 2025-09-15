import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/i18n/app_localizations.dart';
import '../../bookmark/presentation/bookmark_list/cubit/bookmark_list_cubit.dart';
import '../../books/presentation/book_list/cubit/book_list_cubit.dart';
import '../../collection/presentation/collection_list/cubit/collection_list_cubit.dart';
import '../../explore/presentation/browser/explore_browser_icon.dart';
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

    final Color unselectedColor = colorScheme.onSurface.withAlpha(160);
    final Color selectedColor = colorScheme.onSurface;

    return BlocBuilder<HomepageCubit, HomepageState>(
      buildWhen: (HomepageState previous, HomepageState current) =>
          previous.navItem != current.navItem ||
          previous.isEnabled != current.isEnabled,
      builder: (BuildContext context, HomepageState state) {
        return NavigationBar(
          selectedIndex: HomepageNavigationItem.values.indexOf(state.navItem),
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> states) {
              return states.contains(WidgetState.disabled)
                  ? TextStyle(
                      color: selectedColor,
                    )
                  : TextStyle(
                      color: unselectedColor,
                    );
            },
          ),
          destinations: <Widget>[
            NavigationDestination(
              key: const ValueKey<String>('homepage_bookshelf'),
              icon: Icon(
                Icons.shelves,
                color: unselectedColor,
              ),
              selectedIcon: Icon(Icons.shelves, color: colorScheme.onSurface),
              label: appLocalizations.generalBookshelf,
              enabled: !state.navItem.isBookshelf && state.isEnabled,
            ),
            NavigationDestination(
              key: const ValueKey<String>('homepage_explore'),
              icon: ExploreBrowserIcon.outlined(
                color: unselectedColor,
              ),
              selectedIcon: ExploreBrowserIcon(
                color: colorScheme.onSurface,
              ),
              label: appLocalizations.generalExplore,
              enabled: !state.navItem.isDiscovery && state.isEnabled,
            ),
            NavigationDestination(
              key: const ValueKey<String>('homepage_bookmark'),
              icon: Icon(
                Icons.bookmarks_outlined,
                color: unselectedColor,
              ),
              selectedIcon:
                  Icon(Icons.bookmarks_rounded, color: colorScheme.onSurface),
              label: appLocalizations.generalBookmark(2),
              enabled: !state.navItem.isBookmark && state.isEnabled,
            ),
            NavigationDestination(
              key: const ValueKey<String>('homepage_settings'),
              icon: Icon(
                Icons.settings_outlined,
                color: unselectedColor,
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
              case HomepageNavigationItem.explore:
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
