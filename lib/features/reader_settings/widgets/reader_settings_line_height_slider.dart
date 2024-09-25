import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/reader_settings_data.dart';
import '../bloc/reader_settings_bloc.dart';
import 'reader_settings_slider.dart';

class ReaderSettingsLineHeightSlider extends StatelessWidget {
  const ReaderSettingsLineHeightSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderSettingsCubit cubit = BlocProvider.of<ReaderSettingsCubit>(context);
    return BlocBuilder<ReaderSettingsCubit, ReaderSettingsData>(
      builder: (BuildContext context, ReaderSettingsData state) {
        return ReaderSettingsSlider(
          leading: Icon(
            Icons.density_small_rounded,
            color: Theme.of(context).colorScheme.primary,
            semanticLabel: AppLocalizations.of(context)!.accessibilityLineHeightSliderMinIcon,
          ),
          trailing: Icon(
            Icons.density_large_rounded,
            color: Theme.of(context).colorScheme.primary,
            semanticLabel: AppLocalizations.of(context)!.accessibilityLineHeightSliderMaxIcon,
          ),
          min: ReaderSettingsData.minLineHeight,
          max: ReaderSettingsData.maxLineHeight,
          value: state.lineHeight,
          semanticFormatterCallback: (double value) {
            return '${AppLocalizations.of(context)!.accessibilityLineHeightSlider} ${value.toStringAsFixed(1)}';
          },
          onChanged: (double value) {
            cubit.setState(lineHeight: value);
          },
          onChangeEnd: (double value) {
            cubit.setState(lineHeight: value);
            cubit.save();
          },
        );
      },
    );
  }
}
