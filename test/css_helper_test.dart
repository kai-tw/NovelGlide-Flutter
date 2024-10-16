import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:novelglide/toolbox/css_helper.dart'; // Update with your actual package name

void main() {
  group('CssHelper', () {
    test('convertColorToCssRgba should convert Color to CSS rgba string', () {
      // Arrange
      const color = Color.fromARGB(255, 255, 0, 0); // Red color

      // Act
      final result = CssHelper.convertColorToCssRgba(color);

      // Assert
      expect(result, 'rgba(255, 0, 0, 1.0)');
    });

    test('convertColorToCssRgba should handle transparency correctly', () {
      // Arrange
      const color = Color.fromARGB(128, 0, 255, 0); // Semi-transparent green

      // Act
      final result = CssHelper.convertColorToCssRgba(color);

      // Assert
      expect(result, 'rgba(0, 255, 0, 0.5)');
    });
  });
}
