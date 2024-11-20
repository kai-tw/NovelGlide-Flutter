import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../enum/window_class.dart';
import '../../utils/route_utils.dart';
import '../about_page/about_page_scaffold.dart';
import '../backup_manager/backup_manager_scaffold.dart';
import '../developer_page/developer_page.dart';
import '../reset_page/reset_page.dart';
import '../theme_manager/theme_manager.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);

    final List<Widget> buttonList = [
      _ListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.pushRoute(const ThemeManager()),
        ),
        iconData: Icons.format_paint_rounded,
        title: appLocalizations.themeManagerTitle,
      ),
      _ListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.pushRoute(const BackupManagerScaffold()),
        ),
        iconData: Icons.cloud_rounded,
        title: appLocalizations.backupManagerTitle,
      ),
      _ListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.pushRoute(const ResetPage()),
        ),
        iconData: Icons.refresh_rounded,
        title: appLocalizations.resetPageTitle,
      ),
      _ListTile(
        onTap: () => launchUrl(
          Uri.parse(
              'https://www.kai-wu.net/%E6%84%8F%E8%A6%8B%E5%9B%9E%E9%A5%8B/'),
        ),
        iconData: Icons.feedback_rounded,
        title: appLocalizations.settingsFeedback,
      ),
      _ListTile(
        onTap: () => launchUrl(
          Uri.parse('https://www.kai-wu.net/novelglide-privacy-policy'),
        ),
        iconData: Icons.shield_rounded,
        title: appLocalizations.privacyPolicy,
      ),
      _ListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.pushRoute(const AboutPageScaffold()),
        ),
        iconData: Icons.info_outline,
        title: appLocalizations.settingsPageAbout,
      ),
    ];

    if (kDebugMode) {
      buttonList.add(
        _ListTile(
          onTap: () => Navigator.of(context)
              .push(RouteUtils.pushRoute(const DeveloperPage())),
          iconData: Icons.code_rounded,
          title: 'Developer Page',
        ),
      );
    }

    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: windowClass == WindowClass.compact ? 0.0 : 16.0,
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buttonList,
          ),
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final void Function()? onTap;
  final IconData iconData;
  final String title;

  const _ListTile({
    this.onTap,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Icon(iconData),
      ),
      title: Text(title),
    );
  }
}
