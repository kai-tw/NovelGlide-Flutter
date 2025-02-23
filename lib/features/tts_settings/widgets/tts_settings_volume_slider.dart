import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/tts_service_state.dart';
import '../bloc/tts_settings_cubit.dart';
import '../bloc/tts_settings_state.dart';

class TtsSettingsVolumeSlider extends StatelessWidget {
  const TtsSettingsVolumeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<TtsSettingsCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            appLocalizations.ttsSettingsVolume,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
            buildWhen: (previous, current) =>
                previous.ttsState != current.ttsState ||
                previous.volume != current.volume,
            builder: (context, state) {
              return Slider(
                value: state.volume,
                onChanged: state.ttsState == TtsServiceState.stopped
                    ? (value) => cubit.setVolume(value, false)
                    : null,
                onChangeEnd: (value) => cubit.setVolume(value, true),
                min: 0.0,
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
