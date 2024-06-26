import 'package:flutter/material.dart';

import '../../binding_center/binding_center.dart';

abstract class ThemeTemplate {
  abstract final ThemeData lightTheme;
  abstract final ThemeData darkTheme;

  ThemeData getThemeByBrightness({Brightness? brightness}) {
    final Brightness platformBrightness = ThemeBinding.instance.platformDispatcher.platformBrightness;
    return (brightness ?? platformBrightness) == Brightness.light ? lightTheme : darkTheme;
  }
}
