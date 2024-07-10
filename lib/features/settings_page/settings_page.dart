import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/window_class.dart';
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
          onPressed: () => _navigateToTargetPage(context, const ThemeManager(), dialogWidth: 400.0),
          iconData: Icons.format_paint_rounded,
          label: appLocalizations.settingsPageTheme,
        ),
      ),

      /// About page button
      SliverToBoxAdapter(
        child: SettingPageButton(
          onPressed: () => _navigateToTargetPage(context, const AboutPageScaffold(), dialogWidth: 360.0),
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
            onPressed: () => _navigateToTargetPage(context, const DeveloperPage(), dialogWidth: 360.0),
            iconData: Icons.code_rounded,
            label: appLocalizations.settingsPageDeveloperPage,
          ),
        ),
      );
    }

    return HomepageScrollView(slivers: buttonList);
  }

  /// Based on the window size, navigate to the target page
  Future<dynamic> _navigateToTargetPage(BuildContext context, Widget targetPage, {double? dialogWidth}) async {
    switch (WindowClassExtension.getClassByWidth(MediaQuery.of(context).size.width)) {
      case WindowClass.compact:
        return Navigator.of(context).push(MaterialPageRoute(builder: (_) => targetPage));
      default:
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: dialogWidth ?? WindowClassExtension.mediumConstraints.minWidth,
                child: targetPage,
              ),
            );
          },
        );
    }
  }
}
