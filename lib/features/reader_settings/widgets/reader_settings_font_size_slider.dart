import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/reader_settings_data.dart';
import '../bloc/reader_settings_bloc.dart';
import 'reader_settings_slider.dart';

class ReaderSettingsFontSizeSlider extends StatelessWidget {
  const ReaderSettingsFontSizeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderSettingsCubit cubit = BlocProvider.of<ReaderSettingsCubit>(context);
    return BlocBuilder<ReaderSettingsCubit, ReaderSettingsData>(
      builder: (BuildContext context, ReaderSettingsData state) {
        return ReaderSettingsSlider(
          leading: Icon(
            Icons.format_size_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: ReaderSettingsData.minFontSize,
            semanticLabel: AppLocalizations.of(context)!.accessibilityFontSizeSliderMinIcon,
          ),
          trailing: Icon(
            Icons.format_size_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: ReaderSettingsData.maxFontSize,
            semanticLabel: AppLocalizations.of(context)!.accessibilityFontSizeSliderMaxIcon,
          ),
          min: ReaderSettingsData.minFontSize,
          max: ReaderSettingsData.maxFontSize,
          value: state.fontSize,
          semanticFormatterCallback: (double value) {
            return '${AppLocalizations.of(context)!.accessibilityFontSizeSlider} ${value.toStringAsFixed(1)}';
          },
          onChanged: (double value) {
            cubit.setState(fontSize: value);
          },
          onChangeEnd: (double value) {
            cubit.setState(fontSize: value);
            cubit.save();
          },
        );
      },
    );
  }
}
