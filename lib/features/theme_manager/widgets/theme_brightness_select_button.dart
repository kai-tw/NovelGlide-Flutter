import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../processor/theme_processor.dart';
import '../bloc/theme_manager_brightness_bloc.dart';

class ThemeBrightnessSelectButton extends StatelessWidget {
  const ThemeBrightnessSelectButton({super.key, this.brightness});

  final Brightness? brightness;

  @override
  Widget build(BuildContext context) {
    final ThemeManagerBrightnessCubit cubit = BlocProvider.of<ThemeManagerBrightnessCubit>(context);
    return BlocBuilder<ThemeManagerBrightnessCubit, ThemeManagerBrightnessState>(
      builder: (context, state) {
        if (state.brightness == brightness) {
          return OutlinedButton(
            onPressed: null,
            style: OutlinedButton.styleFrom(
              disabledForegroundColor: Theme.of(context).colorScheme.primary,
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: Text(_getBrightnessText(context)),
          );
        } else {
          return ThemeSwitcher.withTheme(
            builder: (context, _, currentTheme) {
              return OutlinedButton(
                onPressed: () {
                  cubit.setBrightness(brightness);
                  ThemeProcessor.switchBrightness(context, brightness: brightness);
                },
                style: OutlinedButton.styleFrom(
                  disabledForegroundColor: currentTheme.colorScheme.primary,
                  side: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                child: Text(_getBrightnessText(context)),
              );
            },
          );
        }
      },
    );
  }

  String _getBrightnessText(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    switch (brightness) {
      case Brightness.light:
        return appLocalizations.brightnessLight;
      case Brightness.dark:
        return appLocalizations.brightnessDark;
      default:
        return appLocalizations.brightnessSystem;
    }
  }
}
