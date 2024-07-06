import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/window_class.dart';
import '../common_components/app_icon.dart';
import 'bloc/navigation_bloc.dart';

class HomepageNavBar extends StatelessWidget {
  const HomepageNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(screenWidth);

    switch (windowClass) {
      case WindowClass.compact:
        return const HomepageNavBarCompactView();
      default:
        return const HomepageNavBarMediumView();
    }
  }
}

class HomepageNavBarCompactView extends StatelessWidget {
  const HomepageNavBarCompactView({super.key});

  @override
  Widget build(BuildContext context) {final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(36.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: NavigationBar(
            height: 64.0,
            selectedIndex: NavigationItem.values.indexOf(state.navItem),
            indicatorColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.shelves, color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),
                selectedIcon: Icon(Icons.shelves, color: Theme.of(context).colorScheme.surface),
                label: appLocalizations.titleBookshelf,
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),
                selectedIcon: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.surface),
                label: appLocalizations.titleBookmarks,
              ),
              NavigationDestination(
                icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),
                selectedIcon: Icon(Icons.settings, color: Theme.of(context).colorScheme.surface),
                label: appLocalizations.titleSettings,
              ),
            ],
            onDestinationSelected: (index) => _onDestinationSelected(context, state, index),
          ),
        );
      }
    );
  }
}

class HomepageNavBarMediumView extends StatelessWidget {
  const HomepageNavBarMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (BuildContext context, NavigationState state) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(24.0),
            ),
            clipBehavior: Clip.hardEdge,
            child: NavigationRail(
              leading: const AppIcon(
                margin: EdgeInsets.all(8.0),
                width: 40,
                height: 40,
              ),
              selectedIndex: NavigationItem.values.indexOf(state.navItem),
              indicatorColor: Colors.transparent,
              unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.surfaceDim),
              selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
              backgroundColor: Colors.transparent,
              labelType: NavigationRailLabelType.none,
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.shelves),
                  selectedIcon: const Icon(Icons.shelves),
                  label: Text(appLocalizations.titleBookshelf),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.bookmark),
                  selectedIcon: const Icon(Icons.bookmark),
                  label: Text(appLocalizations.titleBookmarks),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings),
                  selectedIcon: const Icon(Icons.settings),
                  label: Text(appLocalizations.titleSettings),
                ),
              ],
              onDestinationSelected: (index) => _onDestinationSelected(context, state, index),
            ),
          );
        }
    );
  }
}

void _onDestinationSelected(BuildContext context, NavigationState state, int index) {
  final NavigationCubit cubit = BlocProvider.of<NavigationCubit>(context);
  cubit.setItem(NavigationItem.values[index.clamp(0, NavigationItem.values.length - 1)]);
}
