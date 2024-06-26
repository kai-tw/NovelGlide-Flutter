import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/theme_id.dart';
import 'widgets/theme_select_button.dart';

class ThemeManagerThemeSelector extends StatelessWidget {
  const ThemeManagerThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return ExpansionTile(
      leading: const Icon(Icons.imagesearch_roller_outlined),
      title: Text(appLocalizations.themeListTitle),
      subtitle: Text(appLocalizations.themeListDescription),
      children: [
        SizedBox(
          height: 200,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ThemeSelectButton(themeId: ThemeId.values[index]),
                    childCount: ThemeId.values.length,
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
    );
  }
}
