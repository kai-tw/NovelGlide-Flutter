import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/window_class.dart';
import '../../toolbox/route_helper.dart';
import '../about_page/about_page_scaffold.dart';
import '../backup_manager/backup_manager_scaffold.dart';
import '../developer_page/developer_page.dart';
// import '../store/store_scaffold.dart';
import '../theme_manager/theme_manager.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final WindowClass windowClass =
        WindowClass.getClassByWidth(MediaQuery.of(context).size.width);

    final List<Widget> buttonList = [
      ListTile(
        onTap: () => Navigator.of(context).pushReplacement(
          RouteHelper.pushRoute(const ThemeManager()),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Icon(Icons.format_paint_rounded),
        ),
        title: Text(appLocalizations.themeManagerTitle),
      ),
      ListTile(
        onTap: () => Navigator.of(context).push(
          RouteHelper.pushRoute(const BackupManagerScaffold()),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Icon(Icons.cloud_rounded),
        ),
        title: Text(appLocalizations.backupManagerTitle),
      ),
      // ListTile(
      //   onTap: () => Navigator.of(context).push(RouteHelper.pushRoute(const StoreScaffold())),
      //   leading: const Padding(
      //     padding: EdgeInsets.only(right: 12.0),
      //     child: Icon(Icons.store_rounded),
      //   ),
      //   title: Text(appLocalizations.storeTitle),
      // ),
      ListTile(
        onTap: () => Navigator.of(context).push(
          RouteHelper.pushRoute(const AboutPageScaffold()),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Icon(Icons.info_outline),
        ),
        title: Text(appLocalizations.settingsPageAbout),
      ),
    ];

    if (kDebugMode) {
      buttonList.add(
        ListTile(
          onTap: () => Navigator.of(context)
              .push(RouteHelper.pushRoute(const DeveloperPage())),
          leading: const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.code_rounded),
          ),
          title: const Text('Developer Page'),
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
