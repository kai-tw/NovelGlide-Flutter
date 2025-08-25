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
    return const SharedBottomContainer(
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
                DiscoverBrowserFavoriteButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
