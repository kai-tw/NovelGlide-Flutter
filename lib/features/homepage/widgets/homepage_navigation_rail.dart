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
              selectedIcon: const Icon(Icons.shelves),
              label: Text(appLocalizations.titleBookshelf),
            ),
            NavigationRailDestination(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              icon: const Icon(Icons.bookmark),
              selectedIcon: const Icon(Icons.bookmark),
              label: Text(appLocalizations.titleBookmarks),
            ),
            NavigationRailDestination(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              icon: const Icon(Icons.settings),
              selectedIcon: const Icon(Icons.settings),
              label: Text(appLocalizations.titleSettings),
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
