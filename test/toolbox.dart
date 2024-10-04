import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:novelglide/toolbox/css_helper.dart';

void main() {
  test('ToolBox.CssHelper.convertColorToCssRgba', () {
    final Map<Color, String> testCases = {
      const Color(0xffff5733): 'rgba(255, 87, 51, 1.0)',
      const Color(0xff04151F): 'rgba(4, 21, 31, 1.0)',
      const Color(0xff000000): 'rgba(0, 0, 0, 1.0)',
      const Color(0xffFFFFFF): 'rgba(255, 255, 255, 1.0)',
      const Color.fromARGB(128, 255, 255, 255): 'rgba(255, 255, 255, 0.5)',
    };

    for (final MapEntry<Color, String> testCase in testCases.entries) {
      final String result = CssHelper.convertColorToCssRgba(testCase.key);
      expect(result, testCase.value);
    }
  });
}