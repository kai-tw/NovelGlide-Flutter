import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../common_components/common_back_button.dart';
import '../settings_page/widgets/setting_page_button.dart';
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
      body: Column(
        children: [
          const DeviceInfoPanel(),
          SettingPageButton(
            onPressed: () {
              FirebaseCrashlytics.instance.crash();
            },
            iconData: Icons.error_outline_rounded,
            label: 'Force crash',
          ),
        ],
      ),
    );
  }
}
