import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../binding_center/binding_center.dart';
import '../../data/window_class.dart';
import '../../processor/theme_processor.dart';
import '../common_components/app_frame.dart';
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
          ThemeBinding.instance.addBrightnessListener("ThemeManager", (_) {
            ThemeProcessor.onBrightnessChanged(context);
          });

          return AppFrame(
            child: BlocProvider(
              create: (_) => NavigationCubit(),
              child: const SafeArea(
                child: HomepageScaffold(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomepageScaffold extends StatelessWidget {
  const HomepageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(screenWidth);
    switch (windowClass) {
      case WindowClass.compact:
        return const HomePageCompactView();
      default:
        return const HomePageMediumView();
    }
  }
}

class HomePageCompactView extends StatelessWidget {
  const HomePageCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomepageBody(),
      bottomNavigationBar: HomepageNavBar(),
    );
  }
}

class HomePageMediumView extends StatelessWidget {
  const HomePageMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          HomepageNavBar(),
          Expanded(
            child: HomepageBody(),
          ),
        ],
      ),
    );
  }
}
