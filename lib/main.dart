import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'features/homepage/homepage.dart';
import 'features/log_system/log_system.dart';
import 'firebase_options.dart';
import 'generated/i18n/app_localizations.dart';
import 'theme/default_theme.dart';
import 'utils/file_path.dart';

void main() async {
  // Flutter Initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Package Initialization
  // MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // File Path Initialization
  await FilePath.ensureInitialized();

  // Log Initialization
  LogSystem.ensureInitialized();

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
