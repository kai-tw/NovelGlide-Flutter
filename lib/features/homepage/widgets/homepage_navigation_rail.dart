import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/navigation_bloc.dart';

class HomepageNavigationRail extends StatelessWidget {
  const HomepageNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        return NavigationRail(
          selectedIndex: NavigationItem.values.indexOf(state.navItem),
          indicatorColor: Colors.transparent,
          unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.surfaceDim),
          selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
          backgroundColor: Colors.transparent,
          labelType: NavigationRailLabelType.none,
          destinations: [
            NavigationRailDestination(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              icon: const Icon(Icons.shelves),
              selectedIcon: Icon(Icons.shelves, color: Theme.of(context).colorScheme.surface),
              label: Text(appLocalizations.titleBookshelf),
              disabled: state.navItem == NavigationItem.bookshelf,
            ),
            NavigationRailDestination(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              icon: const Icon(Icons.bookmark),
              selectedIcon: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.surface),
              label: Text(appLocalizations.titleBookmarks),
              disabled: state.navItem == NavigationItem.bookmark,
            ),
            NavigationRailDestination(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              icon: const Icon(Icons.settings),
              selectedIcon: Icon(Icons.settings, color: Theme.of(context).colorScheme.surface),
              label: Text(appLocalizations.titleSettings),
              disabled: state.navItem == NavigationItem.settings,
            ),
          ],
          onDestinationSelected: (index) {
            BlocProvider.of<NavigationCubit>(context)
                .setItem(NavigationItem.values[index.clamp(0, NavigationItem.values.length - 1)]);
          },
        );
      },
    );
  }
}
