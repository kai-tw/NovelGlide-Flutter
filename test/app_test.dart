import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:novel_glide/app/app.dart';
import 'package:novel_glide/core/setup_dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create a GetIt instance
final GetIt getIt = GetIt.instance;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues(<String, Object>{});

  setUpAll(() {
    getIt.reset();
  });

  setUp(() async {
    await setupDependencies();
  });

  group('App', () {
    goldenTest(
      'Android Phone Rendering Test',
      fileName: 'android_phone',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(
          maxWidth: 360,
          maxHeight: 640,
        ),
        children: <Widget>[
          GoldenTestScenario(
            name: 'homepage',
            constraints: const BoxConstraints(
              maxWidth: 360,
              maxHeight: 640,
            ),
            child: const App(),
          ),
        ],
      ),
    );
  });
}
