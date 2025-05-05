import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/route_utils.dart';
import '../../enum/window_size.dart';
import '../../generated/i18n/app_localizations.dart';
import '../about_page/about_page.dart';
import '../backup_service/presentation/backup_service_page.dart';
import '../developer_page/developer_page.dart';
import '../reset_page/reset_page.dart';
import '../tts_service/tts_service.dart';
import 'widgets/settings_list_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final double windowWidth = MediaQuery.sizeOf(context).width;
    final WindowSize windowClass = WindowSize.fromWidth(windowWidth);

    final List<SettingsListTile> buttonList = <SettingsListTile>[
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.pushRoute(const TtsSettingsPage()),
        ),
        iconData: Icons.volume_up_rounded,
        title: appLocalizations.ttsSettingsTitle,
      ),
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.pushRoute(const BackupServicePage()),
        ),
        iconData: Icons.cloud_rounded,
        title: appLocalizations.backupServiceTitle,
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
          RouteUtils.pushRoute(const AboutPage()),
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
            top: windowClass == WindowSize.compact ? 0.0 : 16.0,
            bottom: MediaQuery.paddingOf(context).bottom,
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
