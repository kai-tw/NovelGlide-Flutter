import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/theme_id.dart';
import 'widgets/theme_manager_section_card.dart';
import 'widgets/theme_manager_section_title.dart';
import 'widgets/theme_manager_select_theme_button.dart';

class ThemeManagerThemeSelector extends StatelessWidget {
  const ThemeManagerThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 3;
    const double maxAxisExtent = 80.0;

    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return ThemeManagerSectionCard(
      children: [
        ThemeManagerSectionTitle(
          leadingIcon: Icons.imagesearch_roller_outlined,
          title: appLocalizations.themeListTitle,
          subtitle: appLocalizations.themeListDescription,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          height: min<double>(200, (ThemeId.values.length / crossAxisCount).ceil() * maxAxisExtent),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => ThemeManagerSelectThemeButton(themeId: ThemeId.values[index]),
                    childCount: ThemeId.values.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    mainAxisExtent: maxAxisExtent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
