import 'package:flutter/rendering.dart';

enum WindowClass {
  /// The window size is less than 600 pixels
  compact,
  /// The window size is between 600 and 840 pixels
  medium,
  /// The window size is between 840 and 1280 pixels
  expanded,
  /// The window size is between 1280 and 1600 pixels
  large,
  /// The window size is greater than 1600 pixels
  extraLarge,
}

extension WindowClassExtension on WindowClass {
  static BoxConstraints compactConstraints = const BoxConstraints(minWidth: 0, maxWidth: 600);
  static BoxConstraints mediumConstraints = const BoxConstraints(minWidth: 600, maxWidth: 840);
  static BoxConstraints expandedConstraints = const BoxConstraints(minWidth: 840, maxWidth: 1280);
  static BoxConstraints largeConstraints = const BoxConstraints(minWidth: 1280, maxWidth: 1600);
  static BoxConstraints extraLargeConstraints = const BoxConstraints(minWidth: 1600);

  static WindowClass getClassByWidth(double width) {
    if (width < compactConstraints.maxWidth) {
      return WindowClass.compact;
    } else if (width < mediumConstraints.maxWidth) {
      return WindowClass.medium;
    } else if (width < expandedConstraints.maxWidth) {
      return WindowClass.expanded;
    } else if (width < largeConstraints.maxWidth) {
      return WindowClass.large;
    } else {
      return WindowClass.extraLarge;
    }
  }
}