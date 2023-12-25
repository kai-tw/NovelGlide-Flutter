import 'package:flutter/material.dart';
import 'color_scheme.dart';

ThemeData lightThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme(),
    useMaterial3: true
  );
}

ThemeData darkThemeData() {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: darkColorScheme(),
    useMaterial3: true
  );
}