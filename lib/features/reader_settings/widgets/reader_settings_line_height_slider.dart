import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/reader_settings_data.dart';
import '../../reader/bloc/reader_cubit.dart';
import '../bloc/reader_settings_bloc.dart';
import 'reader_settings_slider.dart';

class ReaderSettingsLineHeightSlider extends StatelessWidget {
  const ReaderSettingsLineHeightSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderSettingsCubit cubit = BlocProvider.of<ReaderSettingsCubit>(context);
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderSettingsCubit, ReaderSettingsData>(
      builder: (BuildContext context, ReaderSettingsData state) {
        return ReaderSettingsSlider(
          leftIcon: Icon(
            Icons.density_small_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          rightIcon: Icon(
            Icons.density_large_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          min: ReaderSettingsData.minLineHeight,
          max: ReaderSettingsData.maxLineHeight,
          value: state.lineHeight,
          onChanged: (double value) {
            cubit.setState(lineHeight: value);
            readerCubit.setSettings(lineHeight: value);
          },
          onChangeEnd: (double value) {
            cubit.setState(lineHeight: value);
            readerCubit.setSettings(lineHeight: value);
            cubit.save();
          },
        );
      },
    );
  }
}
