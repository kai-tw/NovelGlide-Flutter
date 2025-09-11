import 'package:flutter/material.dart';

import '../../../../../enum/window_size.dart';
import '../../../../shared_components/shared_bottom_container.dart';
import 'buttons/explore_browser_favorite_button.dart';
import 'buttons/explore_browser_home_button.dart';
import 'buttons/explore_browser_next_button.dart';
import 'buttons/explore_browser_previous_button.dart';
import 'explore_browser_url_bar.dart';

class ExploreBrowserNavigationBar extends StatelessWidget {
  const ExploreBrowserNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SharedBottomContainer(
        margin: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 12.0,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withAlpha(50),
            blurRadius: 16.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 12.0),
              constraints:
                  BoxConstraints(maxWidth: WindowSize.compact.maxWidth),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ExploreBrowserPreviousButton(),
                  ExploreBrowserNextButton(),
                  ExploreBrowserHomeButton(),
                  ExploreBrowserFavoriteButton(),
                ],
              ),
            ),
            const ExploreBrowserUrlBar(),
          ],
        ),
      ),
    );
  }
}
