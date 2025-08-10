import 'package:flutter/material.dart';

import '../../../generated/i18n/app_localizations.dart';
import '../../homepage/homepage.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return HomepageAppBar(
      iconData: Icons.settings_rounded,
      title: appLocalizations.generalSettings,
    );
  }
}
