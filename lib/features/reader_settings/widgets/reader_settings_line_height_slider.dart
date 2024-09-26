import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/reader_settings_data.dart';
import '../../reader/bloc/reader_cubit.dart';
import '../../reader/bloc/reader_state.dart';
import 'reader_settings_slider.dart';

class ReaderSettingsLineHeightSlider extends StatelessWidget {
  const ReaderSettingsLineHeightSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.readerSettings.lineHeight != current.readerSettings.lineHeight,
      builder: (context, state) {
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
          value: state.readerSettings.lineHeight,
          semanticFormatterCallback: (double value) {
            return '${AppLocalizations.of(context)!.accessibilityLineHeightSlider} ${value.toStringAsFixed(1)}';
          },
          onChanged: (double value) {
            cubit.setSettings(state.readerSettings.copyWith(lineHeight: value));
          },
          onChangeEnd: (double value) {
            cubit.setSettings(state.readerSettings.copyWith(lineHeight: value)..save());
          },
        );
      },
    );
  }
}
