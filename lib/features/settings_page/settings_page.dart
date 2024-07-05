import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../about_page/about_page_scaffold.dart';
import '../developer_page/developer_page.dart';
import '../theme_manager/theme_manager.dart';
import 'widgets/setting_page_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final List<Widget> buttonList = [
      SettingPageButton(
        targetPage: const ThemeManager(),
        iconData: Icons.format_paint_rounded,
        label: appLocalizations.themeTitle,
      ),
      SettingPageButton(
        targetPage: const AboutPageScaffold(),
        iconData: Icons.info_outline,
        label: appLocalizations.titleAbout,
      ),
    ];

    if (kDebugMode) {
      buttonList.add(
        const SettingPageButton(
          targetPage: DeveloperPage(),
          iconData: Icons.code_rounded,
          label: 'Developer Page',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.settings_outlined),
        title: Text(appLocalizations.titleSettings),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: buttonList,
        ),
      ),
    );
  }
}
