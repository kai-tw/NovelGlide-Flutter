import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'core/app_cubit/app_locale_cubit/app_locale_cubit.dart';
import 'core/interfaces/google_api_interfaces/google_api_interfaces.dart';
import 'core/services/file_path.dart';
import 'core/services/log_service.dart';
import 'core/theme/default_theme.dart';
import 'features/homepage/homepage.dart';
import 'features/locale_service/locale_services.dart';
import 'firebase_options.dart';
import 'generated/i18n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ad Initialization
  MobileAds.instance.initialize();

  // Future initializations
  await Future.wait(<Future<void>>[
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    FilePath.ensureInitialized(),
    GoogleApiInterfaces.ensureInitialized(),
    LocaleServices.ensureInitialized(),
  ]);

  // Log Initialization
  LogService.ensureInitialized();

  // Start App
  FirebaseAnalytics.instance.logAppOpen();
  runApp(const AppWrapper());
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<AppLocaleCubit>(create: (_) => AppLocaleCubit()),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final DefaultTheme theme = DefaultTheme();
    return BlocBuilder<AppLocaleCubit, AppLocaleState>(
      builder: (BuildContext context, AppLocaleState state) {
        return MaterialApp(
          title: 'NovelGlide',
          theme: theme.lightTheme,
          darkTheme: theme.darkTheme,
          locale: state.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Homepage(),
          builder: (BuildContext context, Widget? child) => AccessibilityTools(child: child),
          // debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
