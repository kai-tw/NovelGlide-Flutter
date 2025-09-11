import 'package:flutter/material.dart';

import 'widgets/explore_browser_navigation_bar.dart';
import 'widgets/explore_browser_viewer.dart';

class ExploreBrowser extends StatelessWidget {
  const ExploreBrowser({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Expanded(
          child: ExploreBrowserViewer(),
        ),
        ExploreBrowserNavigationBar(),
      ],
    );
  }
}
