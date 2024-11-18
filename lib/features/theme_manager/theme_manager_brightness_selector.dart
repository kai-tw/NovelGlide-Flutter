import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data_model/theme_data_record.dart';
import '../settings_page/setings_card.dart';
import 'bloc/theme_manager_bloc.dart';

class ThemeManagerBrightnessSelector extends StatelessWidget {
  const ThemeManagerBrightnessSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = context.read<ThemeManagerCubit>();

    return SettingsCard(
      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.brightness_4_rounded),
            title: Text(
              appLocalizations.brightnessSelectorTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(appLocalizations.brightnessSelectorDescription),
          ),
          BlocBuilder<ThemeManagerCubit, ThemeManagerState>(
            buildWhen: (previous, current) =>
                previous.brightness != current.brightness,
            builder: (context, state) {
              return ThemeSwitcher.switcher(
                builder: (_, switcher) {
                  return SegmentedButton<Brightness?>(
                    segments: _buildButtonSegments(appLocalizations),
                    selected: {state.brightness},
                    onSelectionChanged: (brightnessSet) =>
                        _onBrightnessChanged(brightnessSet, cubit, switcher),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  List<ButtonSegment<Brightness?>> _buildButtonSegments(
      AppLocalizations appLocalizations) {
    return [
      ButtonSegment<Brightness?>(
        value: null,
        icon: Icon(Icons.brightness_auto_rounded,
            semanticLabel: appLocalizations.brightnessSystem),
      ),
      ButtonSegment<Brightness?>(
        value: Brightness.light,
        icon: Icon(Icons.light_mode_rounded,
            semanticLabel: appLocalizations.brightnessLight),
      ),
      ButtonSegment<Brightness?>(
        value: Brightness.dark,
        icon: Icon(Icons.dark_mode_rounded,
            semanticLabel: appLocalizations.brightnessDark),
      ),
    ];
  }

  Future<void> _onBrightnessChanged(
    Set<Brightness?> brightnessSet,
    ThemeManagerCubit cubit,
    ThemeSwitcherState switcher,
  ) async {
    final brightness = brightnessSet.first;
    await ThemeDataRecord.saveBrightness(brightness);

    cubit.setBrightness(brightness);
    final themeData = await ThemeDataRecord.currentTheme;
    switcher.changeTheme(theme: themeData);
  }
}
