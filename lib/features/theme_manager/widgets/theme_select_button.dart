import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../theme/default_theme.dart';
import '../theme_manager.dart';

class ThemeSelectButton extends StatelessWidget {
  const ThemeSelectButton({super.key, required this.theme});

  final ThemeList theme;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<ThemeList, String> themeNameMap = {
      ThemeList.defaultTheme: appLocalizations.themeListNameDefault,
      ThemeList.defaultReversedTheme: appLocalizations.themeListNameReverse,
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemeSwitcher.withTheme(
          builder: (context, switcher, currentTheme) {
            final ThemeData themeData = _getThemeData(theme, currentTheme.brightness);
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
          child: Text(themeNameMap[theme] ?? "Aa", overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  ThemeData _getThemeData(ThemeList theme, Brightness brightness) {
    switch (theme) {
      case ThemeList.defaultReversedTheme:
        return brightness == Brightness.light ? DefaultTheme.darkTheme : DefaultTheme.lightTheme;
      default:
        return brightness == Brightness.light ? DefaultTheme.lightTheme : DefaultTheme.darkTheme;
    }
  }
}
