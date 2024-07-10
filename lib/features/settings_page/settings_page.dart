import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../about_page/about_page_scaffold.dart';
import '../developer_page/developer_page.dart';
import '../homepage/widgets/homepage_scroll_view.dart';
import '../theme_manager/theme_manager.dart';
import 'widgets/setting_page_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final List<Widget> buttonList = [
      /// Theme manager button
      SliverToBoxAdapter(
        child: SettingPageButton(
          targetPage: const ThemeManager(),
          iconData: Icons.format_paint_rounded,
          label: appLocalizations.settingsPageTheme,
        ),
      ),

      /// About page button
      SliverToBoxAdapter(
        child: SettingPageButton(
          targetPage: const AboutPageScaffold(),
          iconData: Icons.info_outline,
          label: appLocalizations.settingsPageAbout,
        ),
      ),
    ];

    if (kDebugMode) {
      buttonList.add(
        /// Developer page button
        SliverToBoxAdapter(
          child: SettingPageButton(
            targetPage: const DeveloperPage(),
            iconData: Icons.code_rounded,
            label: appLocalizations.settingsPageDeveloperPage,
          ),
        ),
      );
    }

    return HomepageScrollView(slivers: buttonList);
  }
}
