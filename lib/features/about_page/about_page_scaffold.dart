import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/app_icon.dart';
import '../common_components/common_back_button.dart';
import 'widgets/about_page_app_name.dart';
import 'widgets/about_page_app_version.dart';
import 'widgets/about_page_privacy_button.dart';

/// A scaffold widget for the About Page, displaying app information.
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
      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(
                margin: EdgeInsets.symmetric(vertical: 24.0),
                width: 100,
                height: 100,
              ),
              AboutPageAppName(),
              AboutPageAppVersion(),
              AboutPagePrivacyButton(),
            ],
          ),
        ),
      ),
    );
  }
}
