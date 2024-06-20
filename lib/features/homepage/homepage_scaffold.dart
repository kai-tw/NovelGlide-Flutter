import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../binding_center/binding_center.dart';
import '../theme_manager/bloc/theme_manager_processor.dart';
import 'bloc/navigation_bloc.dart';
import 'homepage_body.dart';
import 'homepage_nav_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeBinding.instance.addBrightnessListener("ThemeManager", (_) {
      // TODO: Switch theme.
      // print(Theme.of(context).brightness);
      // print(ThemeManagerProcessor.getThemeIdByData(Theme.of(context)));
    });

    return ThemeSwitchingArea(
      child: BlocProvider(
        create: (_) => NavigationCubit(),
        child: const Scaffold(
          body: HomepageBody(),
          bottomNavigationBar: HomepageNavBar(),
        ),
      )
    );
  }
}
