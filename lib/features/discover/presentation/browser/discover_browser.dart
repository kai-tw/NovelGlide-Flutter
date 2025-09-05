import 'package:flutter/material.dart';

import 'widgets/discover_browser_navigation_bar.dart';
import 'widgets/discover_browser_viewer.dart';

class DiscoverBrowser extends StatelessWidget {
  const DiscoverBrowser({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Expanded(
          child: DiscoverBrowserViewer(),
        ),
        DiscoverBrowserNavigationBar(),
      ],
    );
  }
}
