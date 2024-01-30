import 'package:flutter/material.dart';

ColorScheme darkColorScheme() {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFDADADA),
    onPrimary: Color(0xFF00363D),
    primaryContainer: Color(0xFF004F58),
    onPrimaryContainer: Color(0xFF9EEFFD),
    secondary: Color(0xFFB1CBD0),
    onSecondary: Color(0xFF1C3438),
    secondaryContainer: Color(0xFF334B4F),
    onSecondaryContainer: Color(0xFFCDE7EC),
    tertiary: Color(0xFFBAC6EA),
    onTertiary: Color(0xFF24304D),
    tertiaryContainer: Color(0xFF3B4664),
    onTertiaryContainer: Color(0xFFDAE2FF),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF171717),
    onBackground: Color(0xFFDEE3E5),
    surface: Color(0xFF0E1415),
    onSurface: Color(0xFFDEE3E5),
    surfaceVariant: Color(0xFF3F484A),
    onSurfaceVariant: Color(0xFFBFC8CA),
    outline: Color(0xFF899294),
    outlineVariant: Color(0xFF3F484A),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFDEE3E5),
    // inverseOnSurface: Color(0xFF2B3133),
    inversePrimary: Color(0xFF006874),
    // surfaceDim: Color(0xFF0E1415),
    // surfaceBright: Color(0xFF343A3B),
    // surfaceContainerLowest: Color(0xFF090F10),
    // surfaceContainerLow: Color(0xFF171D1E),
    // surfaceContainer: Color(0xFF1B2122),
    // surfaceContainerHigh: Color(0xFF252B2C),
    // surfaceContainerHighest: Color(0xFF303637)
  );
}

ThemeData darkThemeData() {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: darkColorScheme(),
    splashColor: Colors.transparent,
    useMaterial3: true,
  );
}
