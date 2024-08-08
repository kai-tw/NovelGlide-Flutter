import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'bloc/theme_manager_bloc.dart';
import 'theme_manager_brightness_selector.dart';
import 'theme_manager_theme_selector.dart';

class ThemeManager extends StatelessWidget {
  const ThemeManager({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: BlocProvider(
        create: (_) => ThemeManagerCubit(),
        child: const ThemeManagerScaffold(),
      ),
    );
  }
}

class ThemeManagerScaffold extends StatelessWidget {
  const ThemeManagerScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ThemeManagerCubit cubit = BlocProvider.of<ThemeManagerCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
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
