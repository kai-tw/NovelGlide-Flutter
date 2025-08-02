import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../appearance_settings_dark_mode_card/appearance_settings_dark_mode_card.dart';

class AppearanceSettingsPage extends StatelessWidget {
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.appearance),
      ),
      body: const SafeArea(
        child: Scrollbar(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: AppearanceSettingsDarkModeCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
