part of '../settings_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final double windowWidth = MediaQuery.sizeOf(context).width;
    final WindowSize windowClass = WindowSize.fromWidth(windowWidth);

    final List<Widget> buttonList = <Widget>[
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
          MaterialPageRoute<void>(builder: (_) => const BackupServicePage()),
        ),
        iconData: Icons.cloud_outlined,
        title: appLocalizations.generalBackup,
      ),

      // TTS settings
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const TtsSettingsPage()),
        ),
        iconData: Icons.volume_up_outlined,
        title: appLocalizations.ttsSettingsTitle,
      ),

      // Locale settings
      SettingsListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const LocaleSettingsPage()),
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

      // About
      const AboutPageAppVersion(),
    ];

    if (kDebugMode) {
      // Developer page
      buttonList.add(
        SettingsListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const DeveloperPage()),
          ),
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
