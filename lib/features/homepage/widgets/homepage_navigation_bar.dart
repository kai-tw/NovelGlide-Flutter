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
          backgroundColor: Colors.black87,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.shelves, color: Colors.white.withOpacity(0.5)),
              selectedIcon: const Icon(Icons.shelves, color: Colors.white),
              label: appLocalizations.titleBookshelf,
              enabled: state.navItem != NavigationItem.bookshelf,
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark, color: Colors.white.withOpacity(0.5)),
              selectedIcon: const Icon(Icons.bookmark, color: Colors.white),
              label: appLocalizations.titleBookmarks,
              enabled: state.navItem != NavigationItem.bookmark,
            ),
            NavigationDestination(
              icon: Icon(Icons.settings, color: Colors.white.withOpacity(0.5)),
              selectedIcon: const Icon(Icons.settings, color: Colors.white),
              label: appLocalizations.settingsTitle,
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
