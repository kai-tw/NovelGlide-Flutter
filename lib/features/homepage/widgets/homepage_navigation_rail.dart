import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bookmark_list/bloc/bookmark_list_bloc.dart';
import '../../bookshelf/bloc/bookshelf_bloc.dart';
import '../bloc/homepage_bloc.dart';

class HomepageNavigationRail extends StatelessWidget {
  const HomepageNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final HomepageCubit cubit = BlocProvider.of<HomepageCubit>(context);
    final BookshelfCubit bookshelfCubit = BlocProvider.of<BookshelfCubit>(context);
    final BookmarkListCubit bookmarkListCubit = BlocProvider.of<BookmarkListCubit>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: BlocBuilder<HomepageCubit, HomepageState>(
                builder: (context, state) {
                  return NavigationRail(
                    selectedIndex: HomepageNavigationItem.values.indexOf(state.navItem),
                    indicatorColor: Colors.transparent,
                    unselectedIconTheme: IconThemeData(color: Colors.white.withOpacity(0.5)),
                    backgroundColor: Colors.transparent,
                    labelType: NavigationRailLabelType.none,
                    destinations: [
                      NavigationRailDestination(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        icon: const Icon(Icons.shelves),
                        selectedIcon: const Icon(Icons.shelves, color: Colors.white),
                        label: Text(appLocalizations.bookshelfTitle),
                        disabled: state.navItem == HomepageNavigationItem.bookshelf,
                      ),
                      NavigationRailDestination(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        icon: const Icon(Icons.collections_bookmark_rounded),
                        selectedIcon: const Icon(Icons.collections_bookmark_rounded, color: Colors.white),
                        label: const Text('Collection'),
                        disabled: state.navItem == HomepageNavigationItem.collection,
                      ),
                      NavigationRailDestination(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        icon: const Icon(Icons.bookmarks_rounded),
                        selectedIcon: const Icon(Icons.bookmarks_rounded, color: Colors.white),
                        label: Text(appLocalizations.bookmarkListTitle),
                        disabled: state.navItem == HomepageNavigationItem.bookmark,
                      ),
                      NavigationRailDestination(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        icon: const Icon(Icons.settings),
                        selectedIcon: const Icon(Icons.settings, color: Colors.white),
                        label: Text(appLocalizations.settingsTitle),
                        disabled: state.navItem == HomepageNavigationItem.settings,
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
              ),
            ),
          ),
        );
      },
    );
  }
}
