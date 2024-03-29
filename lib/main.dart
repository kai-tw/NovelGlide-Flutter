import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';

import 'features/homepage/homepage_scaffold.dart';
import 'features/theme/dark_theme.dart';
import 'features/theme/light_theme.dart';
import 'shared/file_path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await filePath.init();
  debugPrint(filePath.toString());
  Hive.defaultDirectory = filePath.hiveRoot;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NovelGlide',
        theme: lightThemeData(),
        darkTheme: darkThemeData(),
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
  }
}
