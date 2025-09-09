import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/homepage/homepage.dart';
import '../features/locale_system/domain/entities/app_locale.dart';
import '../features/locale_system/locale_utils.dart';
import '../features/preference/domain/entities/appearance_preference_data.dart';
import '../generated/i18n/app_localizations.dart';
import '../main.dart';
import 'cubit/app_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  static const bool _enableAccessibilityTools = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (_) => sl<AppCubit>(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) {
          return MaterialApp(
            title: 'NovelGlide',
            theme: state.theme.lightTheme,
            darkTheme: state.theme.darkTheme,
            themeMode: switch (state.themeMode) {
              AppThemeMode.system => ThemeMode.system,
              AppThemeMode.light => ThemeMode.light,
              AppThemeMode.dark => ThemeMode.dark,
            },
            locale: state.userLocale == null
                ? null
                : LocaleUtils.convertAppLocaleToLocale(state.userLocale!),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: LocaleUtils.supportedLocales
                .map((AppLocale appLocale) =>
                    LocaleUtils.convertAppLocaleToLocale(appLocale))
                .toList(),
            home: const Homepage(),
            builder: _enableAccessibilityTools
                ? (BuildContext context, Widget? child) =>
                    AccessibilityTools(child: child)
                : null,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
