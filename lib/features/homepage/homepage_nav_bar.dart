import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/navigation_bloc.dart';
import 'homepage_nav_bar_destination.dart';

class HomepageNavBar extends StatelessWidget {
  const HomepageNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        return NavigationBar(
          selectedIndex: _getSelectedIndex(state),
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          backgroundColor: Theme.of(context).colorScheme.background,
          destinations: [
            HomepageNavBarDestination(Icons.shelves, label: appLocalizations.titleBookshelf),
            HomepageNavBarDestination(Icons.bookmark, label: appLocalizations.titleBookmarks),
            HomepageNavBarDestination(Icons.settings, label: appLocalizations.titleSettings),
          ],
          onDestinationSelected: (index) => _onDestinationSelected(context, state, index),
        );
      },
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
