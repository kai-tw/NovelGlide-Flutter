import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/theme_id.dart';
import 'bloc/theme_manager_bloc.dart';
import 'widgets/theme_manager_select_theme_button.dart';

class ThemeManagerThemeSelector extends StatelessWidget {
  const ThemeManagerThemeSelector({super.key});

  static const double _maxAxisExtent = 100.0;
  static const double _maxCrossAxisExtent = 100.0;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final int crossAxisCount =
        (MediaQuery.of(context).size.width / _maxCrossAxisExtent).floor();

    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
      ),
      child: Column(
        children: [
          _buildListTile(context, appLocalizations),
          _buildThemeGrid(context, crossAxisCount),
        ],
      ),
    );
  }

  Widget _buildListTile(
      BuildContext context, AppLocalizations appLocalizations) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.imagesearch_roller_outlined),
      title: Text(
        appLocalizations.themeListTitle,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(appLocalizations.themeListDescription),
    );
  }

  Widget _buildThemeGrid(BuildContext context, int crossAxisCount) {
    return SizedBox(
      height: min<double>(200,
          (ThemeId.values.length / crossAxisCount).ceil() * _maxAxisExtent),
      child: CustomScrollView(
        controller:
            BlocProvider.of<ThemeManagerCubit>(context).scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ThemeManagerSelectThemeButton(
                  themeId: ThemeId.values[index],
                ),
                childCount: ThemeId.values.length,
              ),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                mainAxisExtent: _maxAxisExtent,
                maxCrossAxisExtent: _maxCrossAxisExtent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
