import 'package:flutter/material.dart';

import '../../data/window_class.dart';
import 'view/toc_scaffold_compact_view.dart';
import 'view/toc_scaffold_medium_view.dart';

class TocScaffold extends StatelessWidget {
  const TocScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);

    switch (windowClass) {
      case WindowClass.compact:
        return const TocScaffoldCompactView();

      default:
        return const TocScaffoldMediumView();
    }
  }
}
