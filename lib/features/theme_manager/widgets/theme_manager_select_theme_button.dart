import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../../../data/theme_id.dart';
import '../../../processor/theme_processor.dart';

class ThemeManagerSelectThemeButton extends StatelessWidget {
  const ThemeManagerSelectThemeButton({super.key, required this.themeId});

  final ThemeId themeId;

  @override
  Widget build(BuildContext context) {
    final String? themeName = ThemeProcessor.getThemeNameById(context, themeId);
    final ThemeData themeData = ThemeProcessor.getThemeDataById(themeId);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemeSwitcher(
          builder: (context) {
            return OutlinedButton(
              onPressed: () => ThemeProcessor.switchTheme(context, id: themeId),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                backgroundColor: themeData.colorScheme.surface,
                foregroundColor: themeData.colorScheme.onSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text("Aa", overflow: TextOverflow.ellipsis),
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
