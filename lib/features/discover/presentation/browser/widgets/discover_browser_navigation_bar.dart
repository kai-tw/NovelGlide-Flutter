import 'package:flutter/material.dart';

import '../../../../shared_components/shared_bottom_container.dart';
import 'buttons/discover_browser_favorite_button.dart';
import 'buttons/discover_browser_home_button.dart';
import 'buttons/discover_browser_next_button.dart';
import 'buttons/discover_browser_previous_button.dart';
import 'discover_browser_url_bar.dart';

class DiscoverBrowserNavigationBar extends StatelessWidget {
  const DiscoverBrowserNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SharedBottomContainer(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withAlpha(50),
            blurRadius: 16.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
        child: const Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DiscoverBrowserPreviousButton(),
                  DiscoverBrowserNextButton(),
                  DiscoverBrowserHomeButton(),
                  DiscoverBrowserFavoriteButton(),
                ],
              ),
            ),
            DiscoverBrowserUrlBar(),
          ],
        ),
      ),
    );
  }
}
