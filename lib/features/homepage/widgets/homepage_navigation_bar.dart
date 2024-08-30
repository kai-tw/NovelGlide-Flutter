import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/homepage_bloc.dart';

class HomepageNavigationBar extends StatelessWidget {
  const HomepageNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final HomepageCubit cubit = BlocProvider.of<HomepageCubit>(context);

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
              icon: Icon(Icons.bookmark, color: Colors.white.withOpacity(0.5)),
              selectedIcon: const Icon(Icons.bookmark, color: Colors.white),
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
            cubit.setItem(HomepageNavigationItem.values[index.clamp(0, HomepageNavigationItem.values.length - 1)]);
          },
        );
      },
    );
  }
}
