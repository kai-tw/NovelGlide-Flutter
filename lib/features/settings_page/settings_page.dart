import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/theme_setting_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: const Icon(Icons.settings_outlined),
          title: Text(appLocalizations.titleSettings),
          pinned: true,
        ),
        const SliverToBoxAdapter(
          child: ThemeSettingButton(),
        ),
      ],
    );
  }
}
