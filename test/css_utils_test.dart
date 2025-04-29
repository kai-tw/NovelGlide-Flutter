import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novelglide/core/utils/css_utils.dart';

void main() {
  group('CssUtils', () {
    test('convertColorToRgba should convert Color to CSS rgba string', () {
      // Arrange
      const Color color = Color.fromARGB(255, 255, 0, 0); // Red color

      // Act
      final String result = CssUtils.convertColorToRgba(color);

      // Assert
      expect(result, 'rgba(255, 0, 0, 1.0)');
    });

    test('convertColorToRgba should handle transparency correctly', () {
      // Arrange
      const Color color =
          Color.fromARGB(128, 0, 255, 0); // Semi-transparent green

      // Act
      final String result = CssUtils.convertColorToRgba(color);

      // Assert
      expect(result, 'rgba(0, 255, 0, 0.5)');
    });
  });
}
