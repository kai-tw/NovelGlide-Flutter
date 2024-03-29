import 'package:flutter/material.dart';

class HomepageNavBarDestination extends StatelessWidget {
  const HomepageNavBarDestination(this.iconData, {super.key});

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
        icon: Icon(
          iconData,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        selectedIcon: Icon(
          iconData,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        label: '');
  }
}