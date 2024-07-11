import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/window_class.dart';
import 'bloc/homepage_bloc.dart';
import 'widgets/homepage_dragging_target_bar.dart';
import 'widgets/homepage_navigation_bar.dart';
import 'widgets/homepage_navigation_rail.dart';

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
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageCubit, HomepageState>(builder: (BuildContext context, HomepageState state) {
      return Container(
        height: 64.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36.0),
        ),
        clipBehavior: Clip.hardEdge,
        child: state.isDragging ? const HomepageDraggingTargetBar() : const HomepageNavigationBar(),
      );
    });
  }
}

class HomepageNavBarMediumView extends StatelessWidget {
  const HomepageNavBarMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(24.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: const HomepageNavigationRail(),
    );
  }
}
