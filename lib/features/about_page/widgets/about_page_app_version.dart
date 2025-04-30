import 'dart:io';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Displays the app version.
class AboutPageAppVersion extends StatelessWidget {
  const AboutPageAppVersion({super.key});

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
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.hasData) {
          final String version = snapshot.data!.version;
          final String buildVersion = snapshot.data!.buildNumber;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(osLogo),
              const SizedBox(width: 8.0),
              Text('v$version${kDebugMode ? ' ($buildVersion)' : ''}'),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
