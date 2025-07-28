import 'dart:io';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Displays the app version.
class AboutPageAppVersion extends StatelessWidget {
  const AboutPageAppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    final IconData osLogo = Platform.isAndroid
        ? Icons.android_rounded
        : Platform.isIOS
            ? Icons.apple_rounded
            : Icons.code_rounded;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
          if (snapshot.hasData) {
            final String appName = snapshot.data!.appName;
            final String version = snapshot.data!.version;
            final String buildVersion = snapshot.data!.buildNumber;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(osLogo, size: 20.0),
                const SizedBox(width: 8.0),
                Text(
                  '$appName v$version${kDebugMode ? ' ($buildVersion)' : ''}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
