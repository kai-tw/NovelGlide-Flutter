import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String name, List<int> bytes, [_]) async {
      final File image =
          await File('screenshots/$name.png').create(recursive: true);
      image.writeAsBytes(bytes);
      return true;
    },
  );
}
