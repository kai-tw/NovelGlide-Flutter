import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../common_components/app_icon.dart';
import '../common_components/common_back_button.dart';

class AboutPageScaffold extends StatelessWidget {
  const AboutPageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(
                        "${snapshot.data?.appName}",
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(
                        '${Platform.operatingSystem} v${snapshot.data?.version} (${snapshot.data?.buildNumber})',
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
