import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';

import 'data/file_path.dart';
import 'features/homepage/homepage.dart';
import 'firebase_options.dart';
import 'processor/theme_processor.dart';

void main() async {
  // Flutter Initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Package Initialization
  MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Hive.defaultDirectory = await FilePath.hiveRoot;

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData initTheme = ThemeProcessor.getThemeDataFromSettings();

    return ThemeProvider(
      initTheme: initTheme,
      builder: (context, initTheme) {
        return MaterialApp(
          title: 'NovelGlide',
          theme: initTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
            Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
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
