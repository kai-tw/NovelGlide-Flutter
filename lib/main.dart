import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';

import 'features/homepage/scaffold.dart';
import 'features/theme/theme.dart';
import 'shared/file_process.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.defaultDirectory = await FileProcess.hiveRoot;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: lightThemeData(),
        builder: (BuildContext context, ThemeData initTheme) {
          return MaterialApp(
              title: 'NovelGlide',
              theme: initTheme,
              // darkTheme: darkThemeData(),
              themeMode: ThemeMode.system,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
              ],
              home: const Homepage());
        });
  }
}
