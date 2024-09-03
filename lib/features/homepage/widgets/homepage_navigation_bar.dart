import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bookmark_list/bloc/bookmark_list_bloc.dart';
import '../../bookshelf/bloc/bookshelf_bloc.dart';
import '../bloc/homepage_bloc.dart';

class HomepageNavigationBar extends StatelessWidget {
  const HomepageNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final HomepageCubit cubit = BlocProvider.of<HomepageCubit>(context);
    final BookshelfCubit bookshelfCubit = BlocProvider.of<BookshelfCubit>(context);
    final BookmarkListCubit bookmarkListCubit = BlocProvider.of<BookmarkListCubit>(context);

    return BlocBuilder<HomepageCubit, HomepageState>(
      builder: (context, state) {
        return NavigationBar(
          selectedIndex: HomepageNavigationItem.values.indexOf(state.navItem),
          indicatorColor: Colors.transparent,
          backgroundColor: Colors.black87,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.shelves, color: Colors.white.withOpacity(0.5)),
              selectedIcon: const Icon(Icons.shelves, color: Colors.white),
              label: appLocalizations.bookshelfTitle,
              enabled: state.navItem != HomepageNavigationItem.bookshelf,
            ),
            NavigationDestination(
              icon: Icon(Icons.collections_bookmark_outlined, color: Colors.white.withOpacity(0.5)),
              selectedIcon: const Icon(Icons.collections_bookmark_outlined, color: Colors.white),
              label: 'Collection',
              enabled: state.navItem != HomepageNavigationItem.collection,
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmarks_outlined, color: Colors.white.withOpacity(0.5)),
              selectedIcon: const Icon(Icons.bookmarks_outlined, color: Colors.white),
              label: appLocalizations.bookmarkListTitle,
              enabled: state.navItem != HomepageNavigationItem.bookmark,
            ),
            NavigationDestination(
              icon: Icon(Icons.settings, color: Colors.white.withOpacity(0.5)),
              selectedIcon: const Icon(Icons.settings, color: Colors.white),
              label: appLocalizations.settingsTitle,
              enabled: state.navItem != HomepageNavigationItem.settings,
            ),
          ],
          onDestinationSelected: (index) {
            switch (state.navItem) {
              case HomepageNavigationItem.bookshelf:
                bookshelfCubit.unfocused();
                break;
              case HomepageNavigationItem.bookmark:
                bookmarkListCubit.unfocused();
                break;
              default:
            }
            cubit.setItem(HomepageNavigationItem.values[index.clamp(0, HomepageNavigationItem.values.length - 1)]);
          },
        );
      },
    );
  }
}
