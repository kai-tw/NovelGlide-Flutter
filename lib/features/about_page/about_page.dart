import 'package:flutter/material.dart';

import '../../generated/i18n/app_localizations.dart';
import '../common_components/app_icon.dart';
import '../common_components/common_back_button.dart';
import 'widgets/about_page_app_name.dart';
import 'widgets/about_page_app_version.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
            children: <Widget>[
              AppIcon(
                margin: EdgeInsets.symmetric(vertical: 24.0),
                width: 100,
                height: 100,
              ),
              AboutPageAppName(),
              AboutPageAppVersion(),
            ],
          ),
        ),
      ),
    );
  }
}
