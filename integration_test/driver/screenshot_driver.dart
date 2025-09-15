import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String name, List<int> bytes, [_]) async {
      final File image = File(name);

      if (!await image.exists()) {
        await image.create(recursive: true);
      }

      await image.writeAsBytes(bytes);
      return true;
    },
  );
}
