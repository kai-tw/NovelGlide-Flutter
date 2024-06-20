import 'package:flutter/material.dart';

import '../../binding_center/binding_center.dart';

abstract class ThemeTemplate {
  abstract final ThemeData lightTheme;
  abstract final ThemeData darkTheme;

  ThemeData getThemeByBrightness({Brightness? brightness}) {
    return (brightness ?? ThemeBinding.instance.platformDispatcher.platformBrightness) == Brightness.light
        ? lightTheme
        : darkTheme;
  }
}
