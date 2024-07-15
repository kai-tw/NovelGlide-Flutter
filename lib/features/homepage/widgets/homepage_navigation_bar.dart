import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/navigation_bloc.dart';

class HomepageNavigationBar extends StatelessWidget {
  const HomepageNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        return NavigationBar(
          selectedIndex: NavigationItem.values.indexOf(state.navItem),
          indicatorColor: Colors.transparent,
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.shelves, color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),
              selectedIcon: Icon(Icons.shelves, color: Theme.of(context).colorScheme.surface),
              label: appLocalizations.titleBookshelf,
              enabled: state.navItem != NavigationItem.bookshelf,
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),
              selectedIcon: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.surface),
              label: appLocalizations.titleBookmarks,
              enabled: state.navItem != NavigationItem.bookmark,
            ),
            NavigationDestination(
              icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),
              selectedIcon: Icon(Icons.settings, color: Theme.of(context).colorScheme.surface),
              label: appLocalizations.titleSettings,
              enabled: state.navItem != NavigationItem.settings,
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
