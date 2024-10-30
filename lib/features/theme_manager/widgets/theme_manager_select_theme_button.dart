import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data_model/theme_data_record.dart';
import '../../../enum/theme_id.dart';

class ThemeManagerSelectThemeButton extends StatelessWidget {
  const ThemeManagerSelectThemeButton({super.key, required this.themeId});

  final ThemeId themeId;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String? themeName = ThemeId.getThemeNameById(context, themeId);
    final Brightness brightness = Theme.of(context).brightness;
    final ThemeData themeData = themeId.getThemeDataByBrightness(brightness);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemeSwitcher(
          builder: (context) {
            return OutlinedButton(
              onPressed: () {
                ThemeDataRecord(themeId: themeId, brightness: brightness)
                    .saveToSettings();
                ThemeSwitcher.of(context).changeTheme(theme: themeData);
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
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
                semanticsLabel: appLocalizations
                    .accessibilityThemeSelectionButton(themeName ?? "Aa"),
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
