enum WindowClass {
  compact,
  medium,
  expanded,
  large,
  extraLarge,
}

extension WindowClassExtension on WindowClass {
  static WindowClass getClassByWidth(double width) {
    if (width < 600) {
      return WindowClass.compact;
    } else if (width < 840) {
      return WindowClass.medium;
    } else if (width < 1280) {
      return WindowClass.expanded;
    } else if (width < 1600) {
      return WindowClass.large;
    } else {
      return WindowClass.extraLarge;
    }
  }
}