import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/navigation_bloc.dart';

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
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.shelves), label: ''),
            NavigationDestination(icon: Icon(Icons.bookmark), label: ''),
            NavigationDestination(icon: Icon(Icons.settings), label: ''),
          ],
          onDestinationSelected: (index) => _onDestinationSelected(context, state, index),
        );
      },
    );
  }

  int _getSelectedIndex(NavigationState state) {
    switch (state.navItem) {
      case NavigationItem.bookshelf:
        return 0;
      case NavigationItem.bookmark:
        return 1;
      case NavigationItem.settings:
        return 2;
    }
  }

  void _onDestinationSelected(BuildContext context, NavigationState state, int index) {
    switch (index) {
      case 0:
        BlocProvider.of<NavigationCubit>(context).setItem(NavigationItem.bookshelf);
        break;
      case 1:
        BlocProvider.of<NavigationCubit>(context).setItem(NavigationItem.bookmark);
        break;
      case 2:
        BlocProvider.of<NavigationCubit>(context).setItem(NavigationItem.settings);
        break;
    }
  }
}