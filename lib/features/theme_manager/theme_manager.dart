import 'dart:math';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data_model/theme_data_record.dart';
import '../../../enum/theme_id.dart';
import '../common_components/common_back_button.dart';
import '../settings_page/settings_card.dart';

part 'bloc/theme_manager_bloc.dart';
part 'brightness/brightness_card.dart';
part 'brightness/brightness_card_title.dart';
part 'brightness/brightness_switcher.dart';
part 'theme_selector/theme_card.dart';
part 'theme_selector/theme_card_title.dart';
part 'theme_selector/theme_grid.dart';
part 'theme_selector/theme_switcher.dart';

class ThemeManager extends StatelessWidget {
  const ThemeManager({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: BlocProvider(
        create: (_) => ThemeManagerCubit(),
        child: const _Scaffold(),
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
        leading: const CommonBackButton(),
        title: Text(appLocalizations.themeManagerTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: cubit.scrollController,
          child: const Column(
            children: [
              _ThemeCard(),
              _BrightnessCard(),
            ],
          ),
        ),
      ),
    );
  }
}
