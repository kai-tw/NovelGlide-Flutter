import 'package:flutter/material.dart';
import 'package:novelglide/features/theme/color_scheme.dart';

ThemeData lightThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme(),
    splashColor: Colors.transparent,
    useMaterial3: true,
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
