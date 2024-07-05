import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'theme_manager_brightness_selector.dart';
import 'theme_manager_theme_selector.dart';

class ThemeManager extends StatelessWidget {
  const ThemeManager({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(appLocalizations.themeTitle),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              ThemeManagerThemeSelector(),
              ThemeManagerBrightnessSelector(),
            ],
          ),
        ),
      ),
    );
  }
}
