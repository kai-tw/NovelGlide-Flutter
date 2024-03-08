import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/navigation_bloc.dart';
import 'homepage_nav_bar_destination.dart';

class HomepageNavBar extends StatelessWidget {
  const HomepageNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        return NavigationBar(
          height: 64.0,
          selectedIndex: _getSelectedIndex(state),
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: Theme.of(context).colorScheme.background,
          destinations: const [
            HomepageNavBarDestination(Icons.shelves),
            HomepageNavBarDestination(Icons.bookmark),
            HomepageNavBarDestination(Icons.settings),
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
