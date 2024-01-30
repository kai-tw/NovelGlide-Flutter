import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../../theme/dark_theme.dart';
import '../../theme/light_theme.dart';

class ReaderSettingsThemeSelector extends StatelessWidget {
  const ReaderSettingsThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final List<ThemeData> themeSelectList = [
      brightness == Brightness.light ? lightThemeData() : darkThemeData(),
      lightThemeData(),
      darkThemeData(),
    ];
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 40.0,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final ThemeData currentTheme = themeSelectList[index];
                  return Container(
                    margin: index > 0 ? const EdgeInsets.only(left: 16.0) : null,
                    child: ThemeSwitcher(
                      builder: (BuildContext context) {
                        return OutlinedButton(
                          onPressed: () {
                            ThemeSwitcher.of(context).changeTheme(theme: currentTheme);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: currentTheme.colorScheme.onBackground,
                            backgroundColor: currentTheme.colorScheme.background,
                          ),
                          child: Text(index == 0 ? 'System' : 'Aa'),
                        );
                      },
                    ),
                  );
                },
                childCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
