import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../generated/i18n/app_localizations.dart';
import '../common_components/app_icon.dart';
import '../common_components/common_back_button.dart';

/// A scaffold widget for the About Page, displaying app information.
class AboutPageScaffold extends StatelessWidget {
  const AboutPageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.settingsPageAbout),
      ),
      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(
                margin: EdgeInsets.symmetric(vertical: 24.0),
                width: 100,
                height: 100,
              ),
              _AppName(),
              _AppVersion(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Displays the app name.
class _AppName extends StatelessWidget {
  const _AppName();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data!.appName,
              style: Theme.of(context).textTheme.titleMedium,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

/// Displays the app version.
class _AppVersion extends StatelessWidget {
  const _AppVersion();

  @override
  Widget build(BuildContext context) {
    IconData osLogo = Icons.code_rounded;

    if (Platform.isAndroid) {
      osLogo = Icons.android_rounded;
    } else if (Platform.isIOS) {
      osLogo = Icons.apple_rounded;
    }

    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final version = snapshot.data!.version;
          final buildVersion = snapshot.data!.buildNumber;
          return IntrinsicWidth(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(osLogo),
              title: Text('v$version${kDebugMode ? ' ($buildVersion)' : ''}'),
              visualDensity: VisualDensity.compact,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
