import 'package:flutter/material.dart';

import '../../../data/window_class.dart';

class HomepageScrollView extends StatelessWidget {
  const HomepageScrollView({super.key, required this.slivers});

  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(MediaQuery.of(context).size.width);
    List<Widget> sliverList = List.from(slivers);

    if (windowClass == WindowClass.compact) {
      sliverList.add(const SliverPadding(padding: EdgeInsets.only(top: kBottomNavigationBarHeight)));
    }

    return Scrollbar(
      child: CustomScrollView(
        slivers: sliverList,
      ),
    );
  }
}