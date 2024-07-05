import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ad_center/bottom_ad_wrapper.dart';
import '../../binding_center/binding_center.dart';
import '../../data/window_class.dart';
import '../../processor/theme_processor.dart';
import 'bloc/navigation_bloc.dart';
import 'homepage_body.dart';
import 'homepage_nav_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: ThemeSwitcher(
        builder: (context) {
          final double screenWidth = MediaQuery.of(context).size.width;
          final WindowClass windowClass = WindowClassExtension.getClassByWidth(screenWidth);

          ThemeBinding.instance.addBrightnessListener("ThemeManager", (_) {
            ThemeProcessor.onBrightnessChanged(context);
          });

          final Widget scaffold;

          switch (windowClass) {
            case WindowClass.compact:
              scaffold = _createCompactWindow(context);
              break;
            default:
              scaffold = _createMediumWindow(context);
              break;
          }

          return BlocProvider(
            create: (_) => NavigationCubit(),
            child: SafeArea(
              child: scaffold,
            ),
          );
        },
      ),
    );
  }

  Widget _createCompactWindow(BuildContext context) {
    return const Scaffold(
      body: BottomAdWrapper(
        child: HomepageBody(),
      ),
      bottomNavigationBar: HomepageNavBar(),
    );
  }

  Widget _createMediumWindow(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          HomepageNavBar(),
          Expanded(
            child: BottomAdWrapper(
              child: HomepageBody(),
            ),
          ),
        ],
      ),
    );
  }
}
