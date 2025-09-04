import 'package:flutter/material.dart';

import 'widgets/buttons/discover_browser_to_download_manager_button.dart';
import 'widgets/discover_browser_navigation_bar.dart';
import 'widgets/discover_browser_title.dart';
import 'widgets/discover_browser_viewer.dart';

class DiscoverBrowserScaffold extends StatelessWidget {
  const DiscoverBrowserScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DiscoverBrowserTitle(),
        actions: const <Widget>[
          DiscoverBrowserToDownloadManagerButton(),
        ],
      ),
      body: const Column(
        children: <Widget>[
          Expanded(
            child: DiscoverBrowserViewer(),
          ),
          DiscoverBrowserNavigationBar(),
        ],
      ),
    );
  }
}
