import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/services/log_service.dart';
import 'core/theme/default_theme.dart';
import 'core/utils/file_path.dart';
import 'features/homepage/homepage.dart';
import 'firebase_options.dart';
import 'generated/i18n/app_localizations.dart';

void main() async {
  // Flutter Initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Package Initialization
  // MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // File Path Initialization
  await FilePath.ensureInitialized();

  // Log Initialization
  LogService.ensureInitialized();

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
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const Homepage(),
      },
      // builder: (BuildContext context, Widget? child) =>
      //     AccessibilityTools(child: child),
      // debugShowCheckedModeBanner: false,
    );
  }
}
