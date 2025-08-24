import 'package:flutter/material.dart';

import 'buttons/discover_browser_home_button.dart';
import 'buttons/discover_browser_next_button.dart';
import 'buttons/discover_browser_previous_button.dart';
import 'discover_browser_url_bar.dart';

class DiscoverBrowserControlBar extends StatelessWidget {
  const DiscoverBrowserControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: const SafeArea(
        child: Column(
          children: <Widget>[
            DiscoverBrowserUrlBar(),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DiscoverBrowserPreviousButton(),
                  DiscoverBrowserNextButton(),
                  DiscoverBrowserHomeButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
