import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/reader_settings_data.dart';
import '../../reader/bloc/reader_cubit.dart';
import '../../reader/bloc/reader_state.dart';

class ReaderSettingsFontSizeSlider extends StatelessWidget {
  const ReaderSettingsFontSizeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8.0),
          width: 32,
          child: Icon(
            Icons.format_size_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: ReaderSettingsData.minFontSize,
          ),
        ),
        BlocBuilder<ReaderCubit, ReaderState>(
          builder: (BuildContext context, ReaderState state) {
            return Expanded(
              child: Slider(
                min: ReaderSettingsData.minFontSize,
                max: ReaderSettingsData.maxFontSize,
                value: state.readerSettings.fontSize,
                onChanged: (double value) => readerCubit.setSettings(fontSize: value),
                onChangeEnd: (double value) => readerCubit.saveSettings(fontSize: value),
              ),
            );
          },
        ),
        Container(
          margin: const EdgeInsets.only(left: 8.0),
          width: 32,
          child: Icon(
            Icons.format_size_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: ReaderSettingsData.maxFontSize,
          ),
        ),
      ],
    );
  }
}
