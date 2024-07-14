import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/theme_id.dart';
import 'bloc/theme_manager_bloc.dart';
import '../common_components/settings_section_card.dart';
import 'widgets/theme_manager_section_title.dart';
import 'widgets/theme_manager_select_theme_button.dart';

class ThemeManagerThemeSelector extends StatelessWidget {
  const ThemeManagerThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    const double maxAxisExtent = 100.0;
    const double maxCrossAxisExtent = 100.0;

    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final int crossAxisCount = (MediaQuery.of(context).size.width / maxCrossAxisExtent).floor();

    return SettingsSectionCard(
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
            controller: BlocProvider.of<ThemeManagerCubit>(context).scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => ThemeManagerSelectThemeButton(themeId: ThemeId.values[index]),
                    childCount: ThemeId.values.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    mainAxisExtent: maxAxisExtent,
                    maxCrossAxisExtent: maxCrossAxisExtent,
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
