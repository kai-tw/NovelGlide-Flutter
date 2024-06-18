import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../theme_switch/theme_switch.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: const Icon(Icons.settings_rounded),
          title: Text(appLocalizations.titleSettings),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(appLocalizations.settingsTitleThemeSwitcher),
                    ),
                    const ThemeSwitch(),
                  ],
                )
              ),
            ),
          ),
        ),
      ],
    );
  }
}
