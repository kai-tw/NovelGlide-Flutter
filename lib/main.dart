import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';

import 'binding_center/binding_center.dart';
import 'features/account_page/account_page.dart';
import 'features/sign_in_page/sign_in_page.dart';
import 'features/register_page/register_page.dart';
import 'features/homepage/homepage_scaffold.dart';
import 'data/file_path.dart';
import 'features/theme/default_theme.dart';
import 'firebase_options.dart';

void main() async {
  BindingCenter.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FilePath.instance.init();
  Hive.defaultDirectory = FilePath.instance.hiveRoot;

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: DefaultTheme.instance.getThemeByBrightness(),
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
            Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
          ],
          initialRoute: "/",
          routes: {
            "/": (_) => const Homepage(),
            "/account": (_) => const AccountPage(),
            "/sign_in": (_) => const SignInPage(),
            "/register": (_) => const RegisterPage(),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
