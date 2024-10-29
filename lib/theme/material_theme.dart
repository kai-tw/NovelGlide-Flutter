import 'package:flutter/material.dart';

import 'theme_template.dart';

class MaterialTheme extends ThemeTemplate {
  static final ThemeData lightTheme =
      ThemeTemplate.getThemeByScheme(_lightColorScheme);
  static final ThemeData darkTheme =
      ThemeTemplate.getThemeByScheme(_darkColorScheme);

  /// The color scheme for light theme
  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.light,
  );

  /// The color scheme for dark theme
  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF9F40CF),
    brightness: Brightness.dark,
  );
}
