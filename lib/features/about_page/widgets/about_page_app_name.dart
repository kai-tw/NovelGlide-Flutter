import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPageAppName extends StatelessWidget {
  const AboutPageAppName({super.key});

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
