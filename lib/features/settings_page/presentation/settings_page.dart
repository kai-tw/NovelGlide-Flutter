import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/widgets/app_version_widget.dart';
import '../../../enum/window_size.dart';
import '../../../generated/i18n/app_localizations.dart';
import '../../appearance/presentation/appearance_settings_page/appearance_settings_page.dart';
import '../../backup/presentation/backup_service_page.dart';
import '../../developer_page/developer_page.dart';
import '../../discover/presentation/browser/discover_browser.dart';
import '../../download_manager/presentation/downloader_list/download_manager.dart';
import '../../feedback/presentation/feedback_page.dart';
import '../../locale_system/presentation/locale_settings_page/locale_settings_page.dart';
import '../../reset_services/reset_service.dart';
import '../../tts_service/presentation/tts_settings_page/tts_settings_page.dart';
import 'widgets/settings_list_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final double windowWidth = MediaQuery.sizeOf(context).width;
    final WindowSize windowClass = WindowSize.fromWidth(windowWidth);

    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: windowClass == WindowSize.compact ? 0.0 : 16.0,
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget?>[
              // Appearance settings
              SettingsListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (_) => const AppearanceSettingsPage()),
                ),
                iconData: Icons.format_paint_outlined,
                title: appLocalizations.appearance,
              ),

              // Backup settings
              SettingsListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (_) => const BackupServicePage()),
                ),
                iconData: Icons.cloud_outlined,
                title: appLocalizations.generalBackup,
              ),

              // TTS settings
              SettingsListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (_) => const TtsSettingsPage()),
                ),
                iconData: Icons.volume_up_outlined,
                title: appLocalizations.ttsSettingsTitle,
              ),

              // Locale settings
              SettingsListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (_) => const LocaleSettingsPage()),
                ),
                iconData: Icons.language_rounded,
                title: appLocalizations.generalLanguages,
              ),

              // Reset settings
              const ResetServiceSettingsListTile(),

              // Feedback
              SettingsListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const FeedbackPage()),
                ),
                iconData: Icons.feedback_outlined,
                title: appLocalizations.generalFeedback,
              ),

              // Privacy policy
              SettingsListTile(
                onTap: () => launchUrl(
                  Uri.parse('https://www.kai-wu.net/novelglide-privacy-policy'),
                ),
                iconData: Icons.shield_outlined,
                title: appLocalizations.privacyPolicy,
                trailing: const Icon(Icons.north_east_rounded),
              ),

              /// ========== Development Sections Start!!! ==========

              // Developer Page
              kDebugMode
                  ? SettingsListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder: (_) => const DeveloperPage()),
                      ),
                      iconData: Icons.code_rounded,
                      title: 'Developer Page',
                    )
                  : null,

              // Discover
              kDebugMode
                  ? SettingsListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const DiscoverBrowser(),
                        ),
                      ),
                      iconData: CupertinoIcons.compass,
                      title: appLocalizations.generalDiscover,
                    )
                  : null,

              // Download Manager
              kDebugMode
                  ? SettingsListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const DownloadManager(),
                        ),
                      ),
                      iconData: Icons.download_rounded,
                      title: 'Download Manager',
                    )
                  : null,

              /// ========== End of Development Sections!!! ==========

              // About
              const AppVersionWidget(),
            ].whereType<Widget>().toList(),
          ),
        ),
      ),
    );
  }
}
