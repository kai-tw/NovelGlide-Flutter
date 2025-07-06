import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/route_utils.dart';
import '../../enum/window_size.dart';
import '../../generated/i18n/app_localizations.dart';
import '../about_page/about_page.dart';
import '../backup_service/presentation/backup_service_page.dart';
import '../developer_page/developer_page.dart';
import '../homepage/homepage.dart';
import '../locale_service/locale_services.dart';
import '../reset_page/reset_page.dart';
import '../tts_service/tts_service.dart';
import 'widgets/settings_list_tile.dart';

part 'settings_app_bar.dart';

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
          RouteUtils.defaultRoute(const TtsSettingsPage()),
        ),
        iconData: Icons.volume_up_outlined,
        title: appLocalizations.ttsSettingsTitle,
      ),
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.defaultRoute(const BackupServicePage()),
        ),
        iconData: Icons.cloud_outlined,
        title: appLocalizations.backupServiceTitle,
      ),
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.defaultRoute(const LocaleSettingsPage()),
        ),
        iconData: Icons.language_rounded,
        title: appLocalizations.languageSettings,
      ),
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.defaultRoute(const ResetPage()),
        ),
        iconData: Icons.refresh_rounded,
        title: appLocalizations.resetPageTitle,
      ),
      SettingsListTile(
        onTap: () => launchUrl(
          Uri.parse('https://www.kai-wu.net/%E6%84%8F%E8%A6%8B%E5%9B%9E%E9%A5%8B/'),
        ),
        iconData: Icons.feedback_outlined,
        title: appLocalizations.settingsFeedback,
        trailing: const Icon(Icons.north_east_rounded),
        // trailingIconData: ,
      ),
      SettingsListTile(
        onTap: () => launchUrl(
          Uri.parse('https://www.kai-wu.net/novelglide-privacy-policy'),
        ),
        iconData: Icons.shield_outlined,
        title: appLocalizations.privacyPolicy,
        trailing: const Icon(Icons.north_east_rounded),
      ),
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          RouteUtils.defaultRoute(const AboutPage()),
        ),
        iconData: Icons.info_outline,
        title: appLocalizations.settingsPageAbout,
      ),
    ];

    if (kDebugMode) {
      buttonList.add(
        SettingsListTile(
          onTap: () => Navigator.of(context).push(RouteUtils.defaultRoute(const DeveloperPage())),
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
