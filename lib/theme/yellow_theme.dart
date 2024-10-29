import 'package:flutter/material.dart';

import 'theme_template.dart';

/// A theme class for the yellow color scheme, extending the ThemeTemplate.
class YellowTheme extends ThemeTemplate {
  /// Light theme configuration using a predefined color scheme.
  static final ThemeData lightTheme =
      ThemeTemplate.getThemeByScheme(_lightColorScheme);

  /// Dark theme configuration using a predefined color scheme.
  static final ThemeData darkTheme =
      ThemeTemplate.getThemeByScheme(_darkColorScheme);

  /// Color scheme for the light theme, based on a seed color.
  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFC107),
    brightness: Brightness.light,
  );

  /// Color scheme for the dark theme, based on a seed color.
  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFEB3B),
    brightness: Brightness.dark,
  );
}
