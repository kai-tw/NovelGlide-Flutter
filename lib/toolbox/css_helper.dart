import 'dart:ui';

/// A utility class for CSS-related helper functions.
class CssHelper {
  /// Converts a [Color] object to a CSS rgba() string.
  /// 
  /// The [color] parameter is the color to convert.
  /// Returns a string in the format 'rgba(red, green, blue, alpha)'.
  static String convertColorToCssRgba(Color color) {
    final red = color.red;
    final green = color.green;
    final blue = color.blue;
    final alpha = (color.alpha / 255).toStringAsFixed(1);

    return 'rgba($red, $green, $blue, $alpha)';
  }

  // Private constructor to prevent instantiation.
  CssHelper._();
}
