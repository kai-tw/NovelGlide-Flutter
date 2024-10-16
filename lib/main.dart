import 'dart:io';

import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

import 'toolbox/file_path.dart';
import 'data/theme_data_record.dart';
import 'features/homepage/homepage.dart';
import 'firebase_options.dart';

void main() async {
  // Flutter Initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Package Initialization
  MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Library Initialization
  Directory libraryDirectory = Directory(await FilePath.libraryRoot);
  if (!libraryDirectory.existsSync()) {
    libraryDirectory.createSync(recursive: true);
  }

  // Theme Initialization
  ThemeDataRecord record = await ThemeDataRecord.fromSettings();
  final ThemeData initialTheme =
      record.themeId.getThemeDataByBrightness(brightness: record.brightness);

  // Log Initialization
  if (kReleaseMode) {
    Logger.level = Level.info;
    Logger.addLogListener(
      (event) => FirebaseCrashlytics.instance
          .log('[${event.time}] <${event.level.name}> ${event.message}'),
    );
  } else {
    Logger.level = Level.all;
  }

  // Start App
  runApp(App(initialTheme: initialTheme));
}

class App extends StatelessWidget {
  final ThemeData initialTheme;

  const App({super.key, required this.initialTheme});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: initialTheme,
      builder: (context, initialTheme) {
        return MaterialApp(
          title: 'NovelGlide',
          theme: initialTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale.fromSubtags(
                languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
            Locale.fromSubtags(
                languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
          ],
          initialRoute: "/",
          routes: {
            "/": (_) => const Homepage(),
          },
          builder: (context, child) => AccessibilityTools(child: child),
          // debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
