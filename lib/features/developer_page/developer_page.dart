import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../common_components/common_back_button.dart';
import '../common_components/common_processing/common_processing_dialog.dart';
import '../settings_page/widgets/setting_page_button.dart';
import 'device_info_panel.dart';
import 'widgets/developer_page_fake_book_button.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: const Text('Developer Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DeviceInfoPanel(),
            /// Force crash button
            SettingPageButton(
              onPressed: () {
                FirebaseCrashlytics.instance.crash();
              },
              iconData: Icons.error_outline_rounded,
              label: 'Force crash',
            ),

            /// Generate a fake book button
            const DeveloperPageFakeBookButton(),

            SettingPageButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const CommonProcessingDialog(),
                );
              },
              iconData: Icons.open_in_new_rounded,
              label: 'Open the processing dialog',
            ),

            SettingPageButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('It\'s a snack bar.'),
                  ),
                );                },
              iconData: Icons.error_outline_rounded,
              label: 'Show the snack bar',
            ),
          ],
        ),
      ),
    );
  }
}
