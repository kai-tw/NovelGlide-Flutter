import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../../theme/default_theme.dart';
import '../../theme/theme_template.dart';
import '../bloc/theme_manager_processor.dart';

class ThemeSelectButton extends StatelessWidget {
  const ThemeSelectButton({super.key, required this.theme});

  final ThemeId theme;

  @override
  Widget build(BuildContext context) {
    final String? themeName = ThemeManagerProcessor.getThemeNameById(context, theme);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemeSwitcher.withTheme(
          builder: (context, switcher, currentTheme) {
            final ThemeTemplate themeTemplate = ThemeManagerProcessor.themeDataMap[theme] ?? DefaultTheme.instance;
            final ThemeData themeData = themeTemplate.getThemeByBrightness();
            return OutlinedButton(
              onPressed: () {
                switcher.changeTheme(theme: themeData);
              },
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
