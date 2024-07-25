import 'package:flutter/material.dart';

import '../../data/window_class.dart';
import 'widgets/homepage_navigation_bar.dart';

class HomepageNavBar extends StatelessWidget {
  const HomepageNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final WindowClass windowClass = WindowClass.getClassByWidth(screenWidth);

    switch (windowClass) {
      case WindowClass.compact:
        return Container(
          height: 64.0,
          margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                blurRadius: 16.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: const HomepageNavigationBar(),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
