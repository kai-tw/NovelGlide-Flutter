import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/appearance/domain/entities/appearance_settings.dart';
import '../features/homepage/homepage.dart';
import '../features/locale_system/domain/entities/app_locale.dart';
import '../features/locale_system/locale_utils.dart';
import '../generated/i18n/app_localizations.dart';
import '../main.dart';
import 'cubit/app_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = sl<AppCubit>();

    return BlocProvider<AppCubit>.value(
      value: cubit,
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
            // builder: (BuildContext context, Widget? child) =>
            //     AccessibilityTools(child: child),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
