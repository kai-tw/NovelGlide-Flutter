import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../homepage/homepage.dart';
import 'discover_browser_icon.dart';
import 'widgets/buttons/discover_browser_to_download_manager_button.dart';
import 'widgets/buttons/discover_browser_to_manual_button.dart';

class DiscoverAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DiscoverAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return HomepageAppBar(
      leading: const DiscoverBrowserIcon(),
      title: appLocalizations.generalDiscover,
      actions: const <Widget>[
        DiscoverBrowserToManualButton(),
        DiscoverBrowserToDownloadManagerButton(),
      ],
    );
  }
}
