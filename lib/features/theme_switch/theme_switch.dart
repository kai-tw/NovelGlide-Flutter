import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../theme/default_theme.dart';
import 'theme_switch_button.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ThemeData> themes = [
      DefaultTheme.lightTheme,
      DefaultTheme.darkTheme,
    ];

    return SizedBox(
      height: 40,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ThemeSwitchButton(themes[index]),
              ),
              childCount: themes.length,
            ),
          ),
        ],
      ),
    );
  }
}
