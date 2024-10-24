import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/route_helper.dart';
import '../common_components/common_back_button.dart';
import '../homepage/bloc/homepage_bloc.dart';
import '../homepage/homepage.dart';
import 'bloc/theme_manager_bloc.dart';
import 'theme_manager_brightness_selector.dart';
import 'theme_manager_theme_selector.dart';

class ThemeManager extends StatelessWidget {
  const ThemeManager({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _navigateToHomepage(context),
      child: ThemeSwitchingArea(
        child: BlocProvider(
          create: (_) => ThemeManagerCubit(),
          child: const _Scaffold(),
        ),
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ThemeManagerCubit cubit = BlocProvider.of<ThemeManagerCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: CommonBackButton(
          onPressed: () => _navigateToHomepage(context),
        ),
        title: Text(appLocalizations.themeManagerTitle),
      ),
      body: SingleChildScrollView(
        controller: cubit.scrollController,
        child: const Column(
          children: [
            ThemeManagerThemeSelector(),
            ThemeManagerBrightnessSelector(),
          ],
        ),
      ),
    );
  }
}

void _navigateToHomepage(BuildContext context) {
  Navigator.of(context).pushReplacement(
    RouteHelper.popRoute(
      const Homepage(initialItem: HomepageNavigationItem.settings),
    ),
  );
}
