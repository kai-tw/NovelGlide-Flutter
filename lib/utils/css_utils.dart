import 'dart:ui';

/// A utility class for CSS-related helper functions.
class CssUtils {
  /// Converts a [Color] object to a CSS rgba() string.
  ///
  /// The [color] parameter is the color to convert.
  /// Returns a string in the format 'rgba(red, green, blue, alpha)'.
  static String convertColorToRgba(Color color) {
    final red = color.r * 255;
    final green = color.g * 255;
    final blue = color.b * 255;
    final alpha = color.a.toStringAsFixed(1);

    return 'rgba($red, $green, $blue, $alpha)';
  }

  // Private constructor to prevent instantiation.
  CssUtils._();
}
