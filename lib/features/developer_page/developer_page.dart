import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../common_components/common_back_button.dart';
import '../settings_page/widgets/setting_page_button.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: const Text('開發者頁面'),
      ),
      body: Column(
        children: [
          SettingPageButton(
            onPressed: () {
              FirebaseCrashlytics.instance.crash();
            },
            iconData: Icons.bug_report_rounded,
            label: '強制 Crash',
          ),
        ],
      ),
    );
  }
}
