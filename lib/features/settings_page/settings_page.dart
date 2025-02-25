import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../enum/window_class.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../utils/route_utils.dart';
import '../about_page/about_page_scaffold.dart';
import '../backup_manager/backup_manager_scaffold.dart';
import '../developer_page/developer_page.dart';
import '../reset_page/reset_page.dart';
import '../tts_settings/tts_settings.dart';
import 'widgets/settings_list_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);

    final buttonList = [
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.pushRoute(const TtsSettings()),
        ),
        iconData: Icons.volume_up_rounded,
        title: appLocalizations.ttsSettingsTitle,
      ),
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.pushRoute(const BackupManagerScaffold()),
        ),
        iconData: Icons.cloud_rounded,
        title: appLocalizations.backupManagerTitle,
      ),
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.pushRoute(const ResetPage()),
        ),
        iconData: Icons.refresh_rounded,
        title: appLocalizations.resetPageTitle,
      ),
      SettingsListTile(
        onTap: () => launchUrl(
          Uri.parse(
              'https://www.kai-wu.net/%E6%84%8F%E8%A6%8B%E5%9B%9E%E9%A5%8B/'),
        ),
        iconData: Icons.feedback_rounded,
        title: appLocalizations.settingsFeedback,
      ),
      SettingsListTile(
        onTap: () => launchUrl(
          Uri.parse('https://www.kai-wu.net/novelglide-privacy-policy'),
        ),
        iconData: Icons.shield_rounded,
        title: appLocalizations.privacyPolicy,
      ),
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.pushRoute(const AboutPageScaffold()),
        ),
        iconData: Icons.info_outline,
        title: appLocalizations.settingsPageAbout,
      ),
    ];

    if (kDebugMode) {
      buttonList.add(
        SettingsListTile(
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
