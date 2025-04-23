enum WindowClass {
  /// The window size is less than 600 pixels
  compact(0, 600),

  /// The window size is between 600 and 840 pixels
  medium(600, 840),

  /// The window size is between 840 and 1280 pixels
  expanded(840, 1280),

  /// The window size is between 1280 and 1600 pixels
  large(1280, 1600),

  /// The window size is greater than 1600 pixels
  extraLarge(1600, double.infinity);

  const WindowClass(this.minWidth, this.maxWidth);

  factory WindowClass.fromWidth(double width) {
    for (final WindowClass windowClass in WindowClass.values) {
      if (windowClass.minWidth <= width && width < windowClass.maxWidth) {
        return windowClass;
      }
    }
    return WindowClass.extraLarge;
  }

  final double minWidth;
  final double maxWidth;
}
