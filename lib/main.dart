import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/domains/file_system_domain/file_system_domain.dart';
import 'core/domains/log_domain/log_domain.dart';
import 'core/presentation/app_global_cubit/app_global_cubit.dart';
import 'features/appearance_services/appearance_services.dart';
import 'features/homepage/homepage.dart';
import 'features/locale_service/locale_services.dart';
import 'firebase_options.dart';
import 'generated/i18n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Future initializations
  await Future.wait(<Future<void>>[
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    FilePath.ensureInitialized(),
    AppearanceServices.ensureInitialized(),
    LocaleServices.ensureInitialized(),
  ]);

  // Log Initialization
  LogDomain.ensureInitialized();

  // Start App
  FirebaseAnalytics.instance.logAppOpen();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppGlobalCubit>(
      create: (_) => AppGlobalCubit(),
      child: BlocBuilder<AppGlobalCubit, AppGlobalState>(
        builder: (BuildContext context, AppGlobalState state) {
          return MaterialApp(
            title: 'NovelGlide',
            theme: state.appearanceData.theme.lightTheme,
            darkTheme: state.appearanceData.theme.darkTheme,
            themeMode: state.appearanceData.themeMode,
            locale: state.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: LocaleServices.supportedLocales,
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => const Homepage(),
            },
            initialRoute: '/',
            builder: (BuildContext context, Widget? child) =>
                AccessibilityTools(child: child),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
