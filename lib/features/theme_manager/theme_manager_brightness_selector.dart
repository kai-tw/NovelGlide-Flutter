import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../processor/theme_processor.dart';
import 'bloc/theme_manager_brightness_bloc.dart';
import 'widgets/theme_manager_section_card.dart';
import 'widgets/theme_manager_section_title.dart';

class ThemeManagerBrightnessSelector extends StatelessWidget {
  const ThemeManagerBrightnessSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => ThemeManagerBrightnessCubit()..refresh(),
      child: ThemeManagerSectionCard(
        children: [
          ThemeManagerSectionTitle(
            leadingIcon: Icons.brightness_4_rounded,
            title: appLocalizations.brightnessSelectorTitle,
            subtitle: appLocalizations.brightnessSelectorDescription,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: ThemeSwitcher.withTheme(
              builder: (context, _, currentTheme) {
                return BlocBuilder<ThemeManagerBrightnessCubit, ThemeManagerBrightnessState>(
                  builder: (context, state) {
                    return SegmentedButton<Brightness?>(
                      segments: [
                        ButtonSegment<Brightness?>(
                          value: null,
                          label: Text(appLocalizations.brightnessSystem),
                          icon: const Icon(Icons.brightness_auto_rounded),
                        ),
                        ButtonSegment<Brightness?>(
                          value: Brightness.light,
                          label: Text(appLocalizations.brightnessLight),
                          icon: const Icon(Icons.light_mode_rounded),
                        ),
                        ButtonSegment<Brightness?>(
                          value: Brightness.dark,
                          label: Text(appLocalizations.brightnessDark),
                          icon: const Icon(Icons.dark_mode_rounded),
                        ),
                      ],
                      selected: {state.brightness},
                      onSelectionChanged: (brightnessSet) {
                        final Brightness? brightness = brightnessSet.first;
                        BlocProvider.of<ThemeManagerBrightnessCubit>(context).setBrightness(brightness);
                        ThemeProcessor.switchBrightness(context, brightness: brightness);
                      },
                    );
                  }
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
