import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../homepage/homepage.dart';
import 'explore_browser_icon.dart';
import 'widgets/buttons/explore_browser_to_download_manager_button.dart';
import 'widgets/buttons/explore_browser_to_manual_button.dart';

class ExploreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ExploreAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return HomepageAppBar(
      leading: const ExploreBrowserIcon(),
      title: appLocalizations.generalExplore,
      actions: const <Widget>[
        ExploreBrowserToManualButton(),
        ExploreBrowserToDownloadManagerButton(),
      ],
    );
  }
}
