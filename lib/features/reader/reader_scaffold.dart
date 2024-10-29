import 'package:flutter/material.dart';

import '../../enum/window_class.dart';
import 'view/reader_scaffold_compact_view.dart';
import 'view/reader_scaffold_medium_view.dart';

class ReaderScaffold extends StatelessWidget {
  const ReaderScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);

    switch (windowClass) {
      case WindowClass.compact:
        return const ReaderScaffoldCompactView();

      default:
        return const ReaderScaffoldMediumView();
    }
  }
}
