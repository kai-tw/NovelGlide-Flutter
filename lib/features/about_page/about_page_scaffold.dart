import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../common_components/app_icon.dart';
import '../common_components/common_back_button.dart';

/// A scaffold widget for the About Page, displaying app information.
class AboutPageScaffold extends StatelessWidget {
  const AboutPageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Future<PackageInfo> packageInfoFuture = PackageInfo.fromPlatform();

    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.settingsPageAbout),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppIcon(
                margin: EdgeInsets.symmetric(vertical: 24.0),
                width: 100,
                height: 100,
              ),
              _buildAppName(context, packageInfoFuture),
              _buildAppVersion(context, packageInfoFuture),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a widget to display the app name.
  Widget _buildAppName(
    BuildContext context,
    Future<PackageInfo> packageInfoFuture,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder<PackageInfo>(
        future: packageInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.appName);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  /// Builds a widget to display the app version and build number.
  Widget _buildAppVersion(
    BuildContext context,
    Future<PackageInfo> packageInfoFuture,
  ) {
    final os = Platform.operatingSystem;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder<PackageInfo>(
        future: packageInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final version = snapshot.data!.version;
            final buildVersion = snapshot.data!.buildNumber;
            return Text('$os v$version ($buildVersion)');
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
