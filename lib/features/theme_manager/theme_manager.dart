import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'widgets/theme_select_button.dart';

class ThemeManager extends StatelessWidget {
  const ThemeManager({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(appLocalizations.themeTitle),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ExpansionTile(
                leading: const Icon(Icons.imagesearch_roller_outlined),
                title: Text(appLocalizations.themeListTitle),
                subtitle: Text(appLocalizations.themeListDescription),
                initiallyExpanded: true,
                children: [
                  SizedBox(
                    height: 200,
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) => ThemeSelectButton(theme: ThemeList.values[index]),
                              childCount: ThemeList.values.length,
                            ),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              mainAxisExtent: 80.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ThemeList {
  defaultTheme,
  defaultReversedTheme,
}
