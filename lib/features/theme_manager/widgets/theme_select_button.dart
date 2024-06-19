import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../../theme/default_reversed_theme.dart';
import '../../theme/default_theme.dart';
import '../theme_manager.dart';

class ThemeSelectButton extends StatelessWidget {
  const ThemeSelectButton({super.key, required this.theme});

  final ThemeList theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemeSwitcher.withTheme(
          builder: (context, switcher, currentTheme) {
            final Brightness brightness = MediaQuery.of(context).platformBrightness;
            final ThemeData themeData = _getThemeData(theme, brightness);
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
          child: Text(_getThemeName(theme), overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  String _getThemeName(ThemeList theme) {
    switch (theme) {
      case ThemeList.defaultReversedTheme:
        return DefaultReversedTheme.name;
      case ThemeList.defaultTheme:
        return DefaultTheme.name;
      default:
        return "Aa";
    }
  }

  ThemeData _getThemeData(ThemeList theme, Brightness brightness) {
    switch (theme) {
      case ThemeList.defaultReversedTheme:
        return brightness == Brightness.light ? DefaultReversedTheme.darkTheme : DefaultReversedTheme.lightTheme;
      default:
        return brightness == Brightness.light ? DefaultTheme.lightTheme : DefaultTheme.darkTheme;
    }
  }
}
