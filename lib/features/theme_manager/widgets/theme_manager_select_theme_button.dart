import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/theme_id.dart';
import '../../../processor/theme_processor.dart';

class ThemeManagerSelectThemeButton extends StatelessWidget {
  const ThemeManagerSelectThemeButton({super.key, required this.themeId});

  final ThemeId themeId;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String? themeName = ThemeProcessor.getThemeNameById(context, themeId);
    final ThemeData themeData = ThemeProcessor.getThemeDataById(themeId);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemeSwitcher(
          builder: (context) {
            return OutlinedButton(
              onPressed: () => ThemeProcessor.switchTheme(context, id: themeId),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                backgroundColor: themeData.colorScheme.surface,
                foregroundColor: themeData.colorScheme.onSurface,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: themeData.colorScheme.outline),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "Aa",
                overflow: TextOverflow.ellipsis,
                semanticsLabel: appLocalizations.accessibilityThemeSelectionButton,
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(themeName ?? "Aa", overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
