import 'package:flutter/material.dart';

import '../../data/window_class.dart';
import 'widgets/reader_navigation_rail.dart';
import 'widgets/reader_navigation_bar.dart';

class ReaderNavigation extends StatelessWidget {
  const ReaderNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(MediaQuery.of(context).size.width);

    switch (windowClass) {
      case WindowClass.compact:
        return const ReaderNavigationBar();
      default:
        return const ReaderNavigationRail();
    }
  }
}
