import 'dart:ui';

class CssHelper {
  static String convertColorToCssRgba(Color color) {
    return 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha / 255})';
  }
}