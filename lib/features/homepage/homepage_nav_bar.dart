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

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        switch (windowClass) {
          case WindowClass.compact:
            return _createCompactWindow(context, state);
          default:
            return _createMediumWindow(context, state);
        }
      },
    );
  }

  Widget _createCompactWindow(BuildContext context, NavigationState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return NavigationBar(
      selectedIndex: _getSelectedIndex(state),
      indicatorColor: Theme.of(context).colorScheme.primaryContainer,
      backgroundColor: Theme.of(context).colorScheme.surface,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.shelves, color: Theme.of(context).colorScheme.onSurface),
          selectedIcon: Icon(Icons.shelves, color: Theme.of(context).colorScheme.onPrimaryContainer),
          label: appLocalizations.titleBookshelf,
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.onSurface),
          selectedIcon: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.onPrimaryContainer),
          label: appLocalizations.titleBookmarks,
        ),
        NavigationDestination(
          icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onSurface),
          selectedIcon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onPrimaryContainer),
          label: appLocalizations.titleSettings,
        ),
      ],
      onDestinationSelected: (index) => _onDestinationSelected(context, state, index),
    );
  }

  Widget _createMediumWindow(BuildContext context, NavigationState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return NavigationRail(
      leading: const AppIcon(width: 40, height: 40),
      selectedIndex: _getSelectedIndex(state),
      indicatorColor: Theme.of(context).colorScheme.primaryContainer,
      backgroundColor: Theme.of(context).colorScheme.surface,
      labelType: NavigationRailLabelType.all,
      groupAlignment: 0,
      destinations: [
        NavigationRailDestination(
          icon: Icon(Icons.shelves, color: Theme.of(context).colorScheme.onSurface),
          selectedIcon: Icon(Icons.shelves, color: Theme.of(context).colorScheme.onPrimaryContainer),
          label: Text(appLocalizations.titleBookshelf),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.onSurface),
          selectedIcon: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.onPrimaryContainer),
          label: Text(appLocalizations.titleBookmarks),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onSurface),
          selectedIcon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onPrimaryContainer),
          label: Text(appLocalizations.titleSettings),
        ),
      ],
      onDestinationSelected: (index) => _onDestinationSelected(context, state, index),
    );
  }

  int _getSelectedIndex(NavigationState state) {
    final List<NavigationItem> list = [NavigationItem.bookshelf, NavigationItem.bookmark, NavigationItem.settings];
    return list.indexOf(state.navItem);
  }

  void _onDestinationSelected(BuildContext context, NavigationState state, int index) {
    final NavigationCubit cubit = BlocProvider.of<NavigationCubit>(context);
    final List<NavigationItem> list = [NavigationItem.bookshelf, NavigationItem.bookmark, NavigationItem.settings];
    cubit.setItem(list[index.clamp(0, list.length - 1)]);
  }
}
