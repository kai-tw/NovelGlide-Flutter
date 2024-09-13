import 'package:flutter/material.dart';

import 'theme_template.dart';

class MaterialTheme extends ThemeTemplate{
  static final ThemeData lightTheme = ThemeTemplate.generateThemeByBrightness(_lightColorScheme);
  static final ThemeData darkTheme = ThemeTemplate.generateThemeByBrightness(_darkColorScheme);

  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.light,
  );

  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF9F40CF),
    brightness: Brightness.dark,
  );
}