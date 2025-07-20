import 'dart:ui';

/// A utility class for CSS-related helper functions.
extension ColorExtension on Color {
  /// Converts a [Color] object to a CSS rgba() string.
  ///
  /// The [color] parameter is the color to convert.
  /// Returns a string in the format 'rgba(red, green, blue, alpha)'.
  String toCssRgba() {
    final double red = r * 255;
    final double green = g * 255;
    final double blue = b * 255;
    final String alpha = a.toStringAsFixed(1);

    return 'rgba($red, $green, $blue, $alpha)';
  }
}
