import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/reader_settings_data.dart';
import '../../reader/bloc/reader_cubit.dart';
import '../../reader/bloc/reader_state.dart';
import 'reader_settings_slider.dart';

class ReaderSettingsFontSizeSlider extends StatelessWidget {
  const ReaderSettingsFontSizeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.fontSize != current.readerSettings.fontSize,
      builder: (context, state) {
        final appLocalizations = AppLocalizations.of(context)!;
        final cubit = BlocProvider.of<ReaderCubit>(context);
        return ReaderSettingsSlider(
          leading: Icon(
            Icons.format_size_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: ReaderSettingsData.minFontSize,
            semanticLabel: appLocalizations.accessibilityFontSizeSliderMinIcon,
          ),
          trailing: Icon(
            Icons.format_size_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: ReaderSettingsData.maxFontSize,
            semanticLabel: appLocalizations.accessibilityFontSizeSliderMaxIcon,
          ),
          min: ReaderSettingsData.minFontSize,
          max: ReaderSettingsData.maxFontSize,
          value: state.readerSettings.fontSize,
          semanticFormatterCallback: (value) {
            return '${appLocalizations.accessibilityFontSizeSlider} ${value.toStringAsFixed(1)}';
          },
          onChanged: (value) {
            cubit.setSettings(fontSize: value);
          },
          onChangeEnd: (value) {
            cubit.setSettings(fontSize: value);
            cubit.saveSettings();
          },
        );
      },
    );
  }
}
