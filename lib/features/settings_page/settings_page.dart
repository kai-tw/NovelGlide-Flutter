import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/window_class.dart';
import '../about_page/about_page_scaffold.dart';
import '../backup_manager/backup_manager_scaffold.dart';
import '../developer_page/developer_page.dart';
import '../store/store_scaffold.dart';
import '../theme_manager/theme_manager.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    final List<Widget> buttonList = [
      ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ThemeManager())),
        leading: const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Icon(Icons.format_paint_rounded),
        ),
        title: Text(appLocalizations.themeManagerTitle),
      ),
      ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BackupManagerScaffold())),
        leading: const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Icon(Icons.cloud_rounded),
        ),
        title: Text(appLocalizations.backupManagerTitle),
      ),
      ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StoreScaffold())),
        leading: const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Icon(Icons.store_rounded),
        ),
        title: Text(appLocalizations.storeTitle),
      ),
      ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AboutPageScaffold())),
        leading: const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Icon(Icons.info_outline),
        ),
        title: Text(appLocalizations.settingsPageAbout),
      ),
      Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom)),
    ];

    if (kDebugMode) {
      buttonList.insert(
        buttonList.length - 1,
        ListTile(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DeveloperPage())),
          leading: const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.code_rounded),
          ),
          title: const Text('Developer Page'),
        ),
      );
    }

    if (windowClass != WindowClass.compact) {
      /// Add padding to align with the navigation rail.
      buttonList.insert(0, const Padding(padding: EdgeInsets.only(top: 16.0)));
    }

    return Scrollbar(
      child: ListView(
        children: buttonList,
      ),
    );
  }
}
