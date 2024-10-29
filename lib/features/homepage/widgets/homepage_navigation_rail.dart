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
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<HomepageCubit>(context);
    final bookshelfCubit = BlocProvider.of<BookshelfCubit>(context);
    final bookmarkListCubit = BlocProvider.of<BookmarkListCubit>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: BlocBuilder<HomepageCubit, HomepageState>(
                buildWhen: (previous, current) =>
                    previous.navItem != current.navItem,
                builder: (context, state) {
                  return NavigationRail(
                    selectedIndex:
                        HomepageNavigationItem.values.indexOf(state.navItem),
                    indicatorColor: Colors.transparent,
                    backgroundColor: colorScheme.surfaceContainer,
                    labelType: NavigationRailLabelType.none,
                    destinations: [
                      _buildDestination(
                        context,
                        iconData: Icons.shelves,
                        label: appLocalizations.bookshelfTitle,
                        disabled:
                            state.navItem == HomepageNavigationItem.bookshelf,
                      ),
                      _buildDestination(
                        context,
                        iconData: Icons.collections_bookmark_rounded,
                        label: appLocalizations.collectionTitle,
                        disabled:
                            state.navItem == HomepageNavigationItem.collection,
                      ),
                      _buildDestination(
                        context,
                        iconData: Icons.bookmarks_rounded,
                        label: appLocalizations.bookmarkListTitle,
                        disabled:
                            state.navItem == HomepageNavigationItem.bookmark,
                      ),
                      _buildDestination(
                        context,
                        iconData: Icons.settings,
                        label: appLocalizations.settingsTitle,
                        disabled:
                            state.navItem == HomepageNavigationItem.settings,
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
                      cubit.setItem(HomepageNavigationItem.values[index.clamp(
                          0, HomepageNavigationItem.values.length - 1)]);
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
    final colorScheme = Theme.of(context).colorScheme;
    return NavigationRailDestination(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      icon: Icon(iconData, color: colorScheme.onSurface.withOpacity(0.64)),
      selectedIcon: Icon(iconData, color: colorScheme.onSurface),
      label: Text(label),
      disabled: disabled,
    );
  }
}
