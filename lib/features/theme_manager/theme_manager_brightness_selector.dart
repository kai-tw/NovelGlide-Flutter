import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/theme_data_record.dart';
import 'bloc/theme_manager_brightness_bloc.dart';
import 'widgets/theme_brightness_select_button.dart';

class ThemeManagerBrightnessSelector extends StatelessWidget {
  const ThemeManagerBrightnessSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Brightness? recordBrightness = ThemeDataRecord.fromSettings().brightness;
    print("Selector: $recordBrightness");
    return BlocProvider(
      create: (context) => ThemeManagerBrightnessCubit(brightness: recordBrightness),
      child: ExpansionTile(
        leading: const Icon(Icons.brightness_4_rounded),
        title: Text(appLocalizations.brightnessSelectorTitle),
        subtitle: Text(appLocalizations.brightnessSelectorDescription),
        children: const [
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ThemeBrightnessSelectButton(),
                ThemeBrightnessSelectButton(brightness: Brightness.light),
                ThemeBrightnessSelectButton(brightness: Brightness.dark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
