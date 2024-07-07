import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.settings_outlined),
      title: Text(AppLocalizations.of(context)!.titleSettings),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}