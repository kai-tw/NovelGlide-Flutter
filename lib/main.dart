import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'core/services/file_path.dart';
import 'core/services/log_service.dart';
import 'core/theme/default_theme.dart';
import 'features/homepage/homepage.dart';
import 'firebase_options.dart';
import 'generated/i18n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Package Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // File Path Initialization
  await FilePath.ensureInitialized();

  // Log Initialization
  LogService.ensureInitialized();

  MobileAds.instance.initialize();

  // Start App
  FirebaseAnalytics.instance.logAppOpen();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final DefaultTheme theme = DefaultTheme();
    return MaterialApp(
      title: 'NovelGlide',
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Homepage(),
      builder: (BuildContext context, Widget? child) =>
          AccessibilityTools(child: child),
      // debugShowCheckedModeBanner: false,
    );
  }
}
