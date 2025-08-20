import 'package:flutter/material.dart';

import 'widgets/discover_browser_url_bar.dart';
import 'widgets/discover_browser_viewer.dart';

class DiscoverBrowserScaffold extends StatelessWidget {
  const DiscoverBrowserScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: const Column(
        children: <Widget>[
          DiscoverBrowserUrlBar(),
          Expanded(
            child: DiscoverBrowserViewer(),
          ),
        ],
      ),
    );
  }
}
