import 'package:flutter/material.dart';

import 'theme_template.dart';

class YellowTheme extends ThemeTemplate{
  static final ThemeData lightTheme = ThemeTemplate.generateThemeByBrightness(_lightColorScheme);
  static final ThemeData darkTheme = ThemeTemplate.generateThemeByBrightness(_darkColorScheme);

  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFC107),
    brightness: Brightness.light,
  );

  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFEB3B),
    brightness: Brightness.dark,
  );
}