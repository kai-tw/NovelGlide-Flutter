import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/theme_data_record.dart';
import 'bloc/theme_manager_brightness_bloc.dart';
import 'widgets/theme_manager_select_brightness_button.dart';
import 'widgets/theme_manager_section_card.dart';
import 'widgets/theme_manager_section_title.dart';

class ThemeManagerBrightnessSelector extends StatelessWidget {
  const ThemeManagerBrightnessSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Brightness? recordBrightness = ThemeDataRecord.fromSettings().brightness;
    return BlocProvider(
      create: (context) => ThemeManagerBrightnessCubit(brightness: recordBrightness),
      child: ThemeManagerSectionCard(
        children: [
          ThemeManagerSectionTitle(
            leadingIcon: Icons.brightness_4_rounded,
            title: appLocalizations.brightnessSelectorTitle,
            subtitle: appLocalizations.brightnessSelectorDescription,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ThemeManagerSelectBrightnessButton(),
                ThemeManagerSelectBrightnessButton(brightness: Brightness.light),
                ThemeManagerSelectBrightnessButton(brightness: Brightness.dark),
              ],
            ),
          )
        ],
      ),
    );
  }
}
