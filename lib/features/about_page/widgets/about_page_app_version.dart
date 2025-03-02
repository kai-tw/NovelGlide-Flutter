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
