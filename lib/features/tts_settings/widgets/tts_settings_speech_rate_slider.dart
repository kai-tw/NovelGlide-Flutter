import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/tts_service_state.dart';
import '../../../generated/i18n/app_localizations.dart';
import '../bloc/tts_settings_cubit.dart';
import '../bloc/tts_settings_state.dart';

class TtsSettingsSpeechRateSlider extends StatelessWidget {
  const TtsSettingsSpeechRateSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<TtsSettingsCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            appLocalizations.ttsSettingsSpeechRate,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
            buildWhen: (previous, current) =>
                previous.ttsState != current.ttsState ||
                previous.speechRate != current.speechRate,
            builder: (context, state) {
              return Slider(
                value: state.speechRate,
                onChanged: state.ttsState == TtsServiceState.stopped
                    ? (value) => cubit.setSpeechRate(value, false)
                    : null,
                onChangeEnd: (value) => cubit.setSpeechRate(value, true),
                min: 0,
                max: 1.0,
                divisions: 10,
              );
            },
          ),
        ],
      ),
    );
  }
}
