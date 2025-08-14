import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tts_state_code.dart';
import '../cubit/tts_settings_cubit.dart';
import '../cubit/tts_settings_state.dart';

class TtsSettingSlider extends StatelessWidget {
  const TtsSettingSlider({
    super.key,
    required this.title,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.divisions,
    required this.valueSelector,
  });

  final String title;
  final Function(double) onChanged;
  final double min;
  final double max;
  final int divisions;
  final double Function(TtsSettingsState) valueSelector;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
            buildWhen: (TtsSettingsState previous, TtsSettingsState current) =>
                previous.ttsState != current.ttsState ||
                previous.data != current.data,
            builder: (BuildContext context, TtsSettingsState state) {
              return Slider(
                value: valueSelector(state),
                onChanged: switch (state.ttsState) {
                  TtsStateCode.ready => onChanged,
                  TtsStateCode.initial => null,
                  TtsStateCode.playing => null,
                  TtsStateCode.paused => null,
                  TtsStateCode.continued => null,
                  TtsStateCode.completed => onChanged,
                  TtsStateCode.canceled => onChanged,
                },
                onChangeEnd: onChanged,
                min: min,
                max: max,
                divisions: divisions,
              );
            },
          ),
        ],
      ),
    );
  }
}
