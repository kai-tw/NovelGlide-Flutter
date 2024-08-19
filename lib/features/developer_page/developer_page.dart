import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../../data/file_path.dart';
import '../common_components/common_back_button.dart';
import 'device_info_panel.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: const Text('Developer Page'),
      ),
      body: ListView(
        children: [
          const DeviceInfoPanel(),

          /// Force crash button
          ListTile(
            onTap: () {
              FirebaseCrashlytics.instance.crash();
            },
            leading: const Icon(Icons.error_outline_rounded),
            title: const Text('Force crash'),
          ),

          ListTile(
            onTap: () {
              debugPrint(FilePath.instance.supportFolder);
              debugPrint(FilePath.instance.documentFolder);
              debugPrint(FilePath.instance.cacheFolder);
              debugPrint(FilePath.instance.tempFolder);
              debugPrint(FilePath.instance.downloadFolder);
              debugPrint(FilePath.instance.libraryFolder);
              debugPrint(FilePath.instance.libraryRoot);
            },
            leading: const Icon(Icons.code_rounded),
            title: const Text('Print FilePath'),
          ),
        ],
      ),
    );
  }
}
