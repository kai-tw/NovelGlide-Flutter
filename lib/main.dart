import 'package:flutter/material.dart';
import 'package:novelglide/ui/pages/main/scaffold.dart';
import 'package:novelglide/ui/theme/theme.dart';

void main() {
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
      home: const MainPage(title: 'NovelGlide')
    );
  }
}

