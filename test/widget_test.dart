// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:novelglide/data/theme_data_record.dart';
import 'package:novelglide/firebase_options.dart';
import 'package:novelglide/main.dart';
import 'package:novelglide/utils/file_path.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Flutter Initialization
    WidgetsFlutterBinding.ensureInitialized();

    // Package Initialization
    MobileAds.instance.initialize();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // File Path Initialization
    await FilePath.ensureInitialized();

    // Theme Initialization
    ThemeDataRecord record = await ThemeDataRecord.fromSettings();
    final ThemeData initTheme =
        record.themeId.getThemeDataByBrightness(brightness: record.brightness);

    // Build our app and trigger a frame.
    await tester.pumpWidget(App(initialTheme: initTheme));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
