import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../processor/theme_processor.dart';
import 'bloc/theme_manager_brightness_bloc.dart';

class ThemeManagerBrightnessSelector extends StatelessWidget {
  const ThemeManagerBrightnessSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => ThemeManagerBrightnessCubit()..refresh(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.brightness_4_rounded),
              title: Text(appLocalizations.brightnessSelectorTitle, style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text(appLocalizations.brightnessSelectorDescription),
            ),
            ThemeSwitcher.withTheme(
              builder: (context, _, currentTheme) {
                return BlocBuilder<ThemeManagerBrightnessCubit, ThemeManagerBrightnessState>(builder: (context, state) {
                  return SegmentedButton<Brightness?>(
                    segments: [
                      ButtonSegment<Brightness?>(
                        value: null,
                        icon: Icon(
                          Icons.brightness_auto_rounded,
                          semanticLabel: appLocalizations.brightnessSystem,
                        ),
                      ),
                      ButtonSegment<Brightness?>(
                        value: Brightness.light,
                        icon: Icon(
                          Icons.light_mode_rounded,
                          semanticLabel: appLocalizations.brightnessLight,
                        ),
                      ),
                      ButtonSegment<Brightness?>(
                        value: Brightness.dark,
                        icon: Icon(
                          Icons.dark_mode_rounded,
                          semanticLabel: appLocalizations.brightnessDark,
                        ),
                      ),
                    ],
                    selected: {state.brightness},
                    onSelectionChanged: (brightnessSet) {
                      final Brightness? brightness = brightnessSet.first;
                      BlocProvider.of<ThemeManagerBrightnessCubit>(context).setBrightness(brightness);
                      ThemeProcessor.switchBrightness(context, brightness: brightness);
                    },
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
